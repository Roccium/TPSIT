// --- DIPENDENZE (IMPORTS) ---
import 'dart:io'; // Necessario per usare la classe File e leggere le immagini salvate
import 'package:flutter/material.dart'; // Componenti grafici base di Flutter
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Per il ConsumerWidget e la lettura dello stato

// Dipendenze interne del tuo progetto (Assicurati che i percorsi siano corretti)
import '../models.dart'; // Per leggere la classe SezioneArmadio e Capo
import '../notiefier.dart'; // Per accedere ad armadioProvider
import 'Camera.dart'; // Per la navigazione verso la fotocamera

// --- WIDGET PRINCIPALE ---
class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ascoltiamo l'unico provider centrale che gestisce tutto l'armadio
    final stato = ref.watch(armadioProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Il Mio Armadio')),
      body: stato.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Errore: $err')),
        data: (sezioni) => ListView.builder(
          itemCount: sezioni.length,
          itemBuilder: (context, i) => CategoriaRow(sezione: sezioni[i]),
        ),
      ),
    );
  }
}

// --- WIDGET DELLA RIGA (CATEGORIA) ---
class CategoriaRow extends StatelessWidget {
  final SezioneArmadio sezione;
  const CategoriaRow({Key? key, required this.sezione}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(sezione.titolo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // sezione.capi non sarà mai null grazie all'architettura sicura
            itemCount: sezione.capi.length + 1,
            itemBuilder: (context, index) {
              // Se siamo all'ultimo elemento, mostriamo il tasto "Aggiungi"
              if (index == sezione.capi.length) {
                return _buildAddButton(context);
              }
              // Altrimenti mostriamo la foto del vestito
              return _buildImageCard(sezione.capi[index].imagePath);
            },
          ),
        ),
      ],
    );
  }
  
  // Tasto per aggiungere una nuova foto
  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (_) => CameraView(categoria: sezione.titolo)
        )
      ),
      child: Container(
        width: 100,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8)
        ),
        child: const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
      ),
    );
  }
  
  // Card che mostra l'immagine salvata in locale (Ottimizzata)
  Widget _buildImageCard(String path) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          // Utilizziamo ResizeImage per decodificare l'immagine in piccolo e risparmiare RAM!
          image: ResizeImage(FileImage(File(path)), width: 300),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}