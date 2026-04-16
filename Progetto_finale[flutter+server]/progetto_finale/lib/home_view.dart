import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../notiefier.dart';
import 'Camera.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final armadio = context.watch<ArmadioNotifier>();

    return Scaffold(
      backgroundColor: Colors.white, // Sfondo pulito come nel disegno
      appBar: AppBar(
        title: const Text('Il Mio Armadio', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0, // Rimuove l'ombra per un look più minimal
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: armadio.isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: armadio.sezioni.length,
            itemBuilder: (context, i) => CategoriaRow(sezione: armadio.sezioni[i]),
          ),
    );
  }
}

class CategoriaRow extends StatelessWidget {
  final SezioneArmadio sezione;
  
  const CategoriaRow({Key? key, required this.sezione}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Titolo della categoria (name of rows)
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            sezione.titolo, 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
        ),

        // 2. Lista scorrevole delle foto (solo le foto, niente tasto '+')
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: sezione.capi.length, // Ora contiamo solo i capi salvati
            itemBuilder: (context, index) {
              return _buildImageCard(sezione.capi[index].imagePath);
            },
          ),
        ),

        // 3. Linea di divisione con bottone "+" sovrapposto al centro
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // La linea orizzontale nera
              const Divider(
                color: Colors.black,
                thickness: 2.5,
              ),
              
              // Il bottone "+" centrale
              _buildAddButton(context),
            ],
          ),
        ),
      ],
    );
  }

  // --- WIDGET PERSONALIZZATI ---

  Widget _buildImageCard(String path) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Aggiunto il bordo nero marcato come nel tuo schizzo
        border: Border.all(color: Colors.black, width: 2.5),
        image: DecorationImage(
          image: ResizeImage(FileImage(File(path)), width: 300),
          fit: BoxFit.cover,
        )
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => CameraView(categoria: sezione.titolo))
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          // Bordo nero circolare per far staccare il bottone dalla linea
          border: Border.all(color: Colors.black, width: 2.5),
        ),
        child: const Icon(
          Icons.add, 
          size: 30, 
          color: Colors.black,
        ),
      ),
    );
  }
}