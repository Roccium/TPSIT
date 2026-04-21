import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../notiefier.dart';
import 'camera.dart';

const double appStrokeWidth = 2;
const Color appStrokeColor = Color.fromARGB(255, 255, 198, 75);//same
const Color appBackgroundColor = Color.fromARGB(255, 155, 138, 255);//robe fige possibili

class HomeView extends StatelessWidget {
  const HomeView({super.key}); 

  @override
  Widget build(BuildContext context) {
    final armadio = context.watch<ArmadioNotifier>();

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: const Text('Il Mio Armadio', style: TextStyle(color: appStrokeColor, fontWeight: FontWeight.bold)),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: appStrokeColor),
      ),
      body: armadio.isLoading 
        ? const Center(child: CircularProgressIndicator(color: appStrokeColor))
        : ListView.builder(
            itemCount: armadio.sezioni.length,
            itemBuilder: (context, i) {
              final isVisibile = [2,4,5].contains(i);
              final isUltimoBlocco = i == armadio.sezioni.length - 1;
              
              // LOGICA DI BUSINESS: 
              // Mostriamo il "+" se è l'ultimo blocco E non abbiamo raggiunto il limite.
              // Mostriamo il cestino per tutti gli altri blocchi.
              final bool mostraSeparatore = !isUltimoBlocco || (isUltimoBlocco && armadio.sezioni.length < 3);
              //final isUltimoBlocco = i == armadio.sezioni.length - 1;
              return Column(
                    children: [
                      CategoriaRow(sezione: armadio.sezioni[i]),
                      //continuare
                      if(mostraSeparatore) DynamicSeparator(
                        // Se è l'ultimo mostriamo "+", altrimenti il cestino (o "-")
                        icon: isUltimoBlocco ? Icons.add : Icons.delete_outline,
                        onTap: () {
                          if (isVisibile) {
                            // Funzione di AGGIUNTA
                            // Es: armadio.aggiungiNuovaCategoria();
                            debugPrint('Aggiungo una nuova riga di categoria!');
                          } else {
                            // Funzione di RIMOZIONE
                            // Es: armadio.rimuoviCategoria(i);
                            debugPrint('Rimuovo la categoria all\'indice $i!');
                          }
                        },
                      ),
                    ],
              );
            },
          ),
    );
  }
}

class CategoriaRow extends StatelessWidget {
  final SezioneArmadio sezione;
  
  const CategoriaRow({super.key, required this.sezione});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Titolo della categoria
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 12.0),
          child: Text(
            sezione.titolo, 
            style: const TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            )
          ),
        ),

        // 2. Lista scorrevole delle foto + Bottone di aggiunta
        SizedBox(
          height: 130, 
          child: ListView.builder(
            physics: const BouncingScrollPhysics(), 
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // IL TRUCCO DEL +1: Aggiungiamo 1 per fare spazio al bottone
            itemCount: sezione.capi.length + 1,
            itemBuilder: (context, index) {
              if (index == sezione.capi.length) {
                return _buildTrailingAddCard(context);//+ di foto
              }
              return _buildImageCard(sezione.capi[index].imagePath);//ritorna immagine easy
            },
          ),
        ),
      ],
    );
  }

 // DA AGGIUNGERE IL CANCELLARE LA FOTO

  Widget _buildImageCard(String path) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      clipBehavior: Clip.antiAlias, 
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: appStrokeColor, width: appStrokeWidth),
        image: DecorationImage(
          image: ResizeImage(FileImage(File(path)), width: 300),
          fit: BoxFit.cover,
        )
      ),
    );
  }

  // NUOVO: La card per aggiungere un elemento a fine lista
  Widget _buildTrailingAddCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => CameraView(categoria: sezione.titolo))
      ),
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100, 
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: appStrokeColor, width: appStrokeWidth),
        ),
        child: const Center(
          child: Icon(
            Icons.add_a_photo,
            size: 36, 
            color: appStrokeColor,
          ),
        ),
      ),
    );
  }

}



class DynamicSeparator extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const DynamicSeparator({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Divider(
            color: appStrokeColor,
            thickness: appStrokeWidth,
            height: appStrokeWidth, 
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 54, 
              height: 54,
              decoration: BoxDecoration(
                color: appBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: appStrokeColor, width: appStrokeWidth),
              ),
              child: Icon(
                icon, 
                size: 32, 
                color: appStrokeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}