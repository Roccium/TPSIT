import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../notiefier.dart';
import 'camera.dart';

// ─────────────────────────────────────────────────────────────────────────────
// COSTANTI DI STILE
// ─────────────────────────────────────────────────────────────────────────────

const double appStrokeWidth    = 2.5;
const Color  appStrokeColor    = Color.fromARGB(255, 255, 198, 75); // Giallo/Oro per il tratto
const Color  appBackgroundColor = Color.fromARGB(255, 155, 138, 255); // Sfondo base
const Color  appDarkColor      = Color(0xFF1A1A2E);

const Map<String, IconData> kCategoriaIcone = {
  'Cappelli':  Icons.accessibility_new,
  'Collane':   Icons.circle_outlined,
  'Maglie':    Icons.checkroom,
  'Cinture':   Icons.horizontal_rule,
  'Pantaloni': Icons.airline_seat_legroom_normal,
  'Scarpe':    Icons.snowshoeing,
};

// ─────────────────────────────────────────────────────────────────────────────
// HOME VIEW (Layout Spaziale "Profilo del Corpo")
// ─────────────────────────────────────────────────────────────────────────────

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final armadio = context.watch<ArmadioNotifier>();
    
    return Scaffold(
      // Sfondo bianco pulito come richiesto per il contrasto con il profiling
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text(
          'Componi Outfit',
          style: TextStyle(color: appDarkColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: armadio.isLoading
          ? const Center(child: CircularProgressIndicator(color: appDarkColor))
          : LayoutBuilder(
              builder: (context, constraints) {
                // Sostituiamo i container colorati con i nostri nuovi widget BodyZone.
                // Assicurati che gli indici corrispondano all'ordine nel tuo Notifier!
                // 0: Cappelli, 1: Collane, 2: Maglie, 3: Cinture, 4: Pantaloni, 5: Scarpe
                return Stack(
                  children: [
                    // Sfondo silhouette grigia (Opzionale: qui potresti mettere un'immagine di sfondo fissa)
                    // Image.asset('assets/silhouette.png', fit: BoxFit.contain, width: double.infinity),

                    // 1. COLLANE (Indice 1)
                    if (armadio.sezioni.length > 1)
                      Align(
                        alignment: const Alignment(0, -0.7),
                        child: FractionallySizedBox(
                          widthFactor: 0.5,
                          heightFactor: 0.1, // Aumentato leggermente per renderlo cliccabile
                          child: BodyZone(sezione: armadio.sezioni[1]),
                        ),
                      ),

                    // 2. MAGLIETTA (Indice 2)
                    if (armadio.sezioni.length > 2)
                      Align(
                        alignment: const Alignment(0, -0.4),
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          heightFactor: 0.35,
                          child: BodyZone(sezione: armadio.sezioni[2]),
                        ),
                      ),

                    // 3. CINTURA (Indice 3)
                    if (armadio.sezioni.length > 3)
                      Align(
                        alignment: const Alignment(0, 0.09),
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          heightFactor: 0.08,
                          child: BodyZone(sezione: armadio.sezioni[3]),
                        ),
                      ),

                    // 4. PANTALONI (Indice 4)
                    if (armadio.sezioni.length > 4)
                      Align(
                        alignment: const Alignment(0, 0.8),
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          heightFactor: 0.4,
                          child: BodyZone(sezione: armadio.sezioni[4]),
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BODY ZONE (Il blocco interattivo sul corpo)
// ─────────────────────────────────────────────────────────────────────────────

class BodyZone extends StatelessWidget {
  final SezioneArmadio sezione;

  const BodyZone({super.key, required this.sezione});

  // Funzione che apre il Pop-up dal basso (Modal Bottom Sheet)
  void _apriPopupGalleria(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Sfondo trasparente per far vedere i bordi arrotondati
      isScrollControlled: true, // Permette al popup di essere più alto se necessario
      builder: (context) => PopupCategoria(sezione: sezione),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImages = sezione.capi.isNotEmpty;
    final String? coverPath = sezione.coverPath ?? (hasImages ? sezione.capi.last.imagePath : null);

    return GestureDetector(
      onTap: () => _apriPopupGalleria(context),
      child: Container(
        margin: const EdgeInsets.all(4.0), // Un piccolo margine per staccare i vari pezzi
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // Grigio chiaro stile "profiling" se è vuoto, trasparente se c'è l'immagine
          color: coverPath == null ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          // Bordo stile tratteggiato o solido per rimarcare la zona
          border: Border.all(color: Colors.grey.shade400, width: 2, style: BorderStyle.solid),
          image: coverPath != null
              ? DecorationImage(
                  image: ResizeImage(FileImage(File(coverPath)), width: 400),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: coverPath == null
            ? Center(
                child: Icon(
                  kCategoriaIcone[sezione.titolo] ?? Icons.add_a_photo, 
                  color: Colors.grey.shade400, 
                  size: 32
                ),
              )
            : null, // Se c'è l'immagine, non mostriamo nulla sopra (lasciamo parlare il vestito)
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// POP-UP CATEGORIA (Il Bottom Sheet con la Galleria)
// ─────────────────────────────────────────────────────────────────────────────

class PopupCategoria extends StatelessWidget {
  final SezioneArmadio sezione;

  const PopupCategoria({super.key, required this.sezione});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Il popup sarà alto solo quanto serve
          children: [
            // Maniglia di scorrimento (il trattino grigio in alto)
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            
            // Titolo e istruzioni
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sezione.titolo,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: appDarkColor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context), // Chiude il popup
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tieni premuto un capo per impostarlo come sfondo.",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),

            // La riga scorrevole delle foto (riutilizziamo la tua logica ottima)
            CategoriaRow(
              sezione: sezione,
              onSetCover: (path) {
                // Quando un utente tiene premuto, aggiorniamo il Notifier!
                context.read<ArmadioNotifier>().setCategoriaCover(sezione.titolo, path);
              },
            ),
            
            const SizedBox(height: 24), // Spazio extra sul fondo
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CATEGORIA ROW (Invariata, gestisce le immagini orizzontali e fotocamera)
// ─────────────────────────────────────────────────────────────────────────────

class CategoriaRow extends StatelessWidget {
  final SezioneArmadio sezione;
  final Function(String path)? onSetCover;

  const CategoriaRow({super.key, required this.sezione, this.onSetCover});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: sezione.capi.length + 1,
        itemBuilder: (context, index) {
          if (index == sezione.capi.length) {
            return _buildAddCard(context);
          }

          final capo = sezione.capi[index];
          final bool isCover = sezione.coverPath == capo.imagePath;

          return GestureDetector(
            onLongPress: () {
              if (onSetCover != null) onSetCover!(capo.imagePath);
              Feedback.forLongPress(context);
            },
            child: Stack(
              children: [
                _buildImageCard(capo.imagePath),
                if (isCover)
                  Positioned(
                    top: 8, right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: appStrokeColor, shape: BoxShape.circle),
                      child: const Icon(Icons.star, color: Colors.white, size: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageCard(String path) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 2), // Bordo più sobrio per il popup
      ),
      child: Image(
        image: ResizeImage(FileImage(File(path)), width: 300),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAddCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Chiude il popup prima di aprire la fotocamera per mantenere lo stack di navigazione pulito
        Navigator.pop(context); 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CameraView(categoria: sezione.titolo)),
        );
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid),
        ),
        child: Center(
          child: Icon(Icons.add_a_photo, size: 32, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}