import 'dart:io';
import 'dart:async';
import 'dart:isolate'; 
import 'package:flutter/widgets.dart'; // Sostituito riverpod con i widget base di Flutter
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import '../database_helper.dart'; 
import '../models.dart';          

// --- 1. VARIABILE GLOBALE FOTOCAMERE ---
// Senza Riverpod, possiamo usare una semplice variabile globale per memorizzare le fotocamere all'avvio.
List<CameraDescription> globalCameras = [];

class ArmadioNotifier with ChangeNotifier {
  final _db = DatabaseHelper.istanza;
  final List<String> _categorieFisse = ['Cappelli','Collane','Maglie','Cinture','Pantaloni','Scarpe'];

  // Stato interno
  List<SezioneArmadio> _sezioni = [];
  bool _isLoading = true;

  // Getters per leggere lo stato dalla UI
  List<SezioneArmadio> get sezioni => _sezioni;
  bool get isLoading => _isLoading;

  // Equivalente al "firstQuery" dell'esempio precedente
  Future<void> caricaDati() async {
    _isLoading = true;
    notifyListeners(); // Avvisa la UI che stiamo caricando

    try {
      final tutti = await _db.getAllCapi();
      
      // Creiamo la mappa delle sezioni
      Map<String, List<Capo>> mappa = { for (var c in _categorieFisse) c: [] };

      for (var capo in tutti) {
        if (mappa.containsKey(capo.categoria)) {
          mappa[capo.categoria]!.add(capo);
        }
      }

      // Aggiorniamo la lista finale
      _sezioni = mappa.entries.map((e) => SezioneArmadio(titolo: e.key, capi: e.value)).toList();
      
    } catch (e) {
      print("Errore nel caricamento dati: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Avvisa la UI che abbiamo finito e i dati sono pronti
    }
  }

  // --- AZIONI (CRUD) ---

  // Azione scatto: aggiunge un capo e aggiorna lo stato
  Future<void> aggiungiCapo(CameraController controller, String categoria) async {
    if (!controller.value.isInitialized) return;

    _isLoading = true;
    notifyListeners();

    try {
      final image = await controller.takePicture();
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Isolate.run per spostare la foto in background senza laggare
      final savedPath = await Isolate.run(() async {
        final source = File(image.path);
        final destination = await source.copy(path);
        if (await source.exists()) await source.delete(); // Pulisce la cache
        return destination.path;
      });

      // Salva nel database SQLite
      await _db.insertCapo(Capo(categoria: categoria, imagePath: savedPath));
      
      // Ricarica tutto dal DB per avere lo stato sincronizzato
      await caricaDati(); 
    } catch (e) {
      print("Errore durante l'aggiunta del capo: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // Metodo per eliminare un capo (Database + File)
  Future<void> eliminaCapo(Capo capo) async {
    if (capo.id == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // 1. Elimina dal Database
      await _db.deleteCapo(capo.id!);
      
      // 2. Elimina il file fisico per liberare memoria
      final file = File(capo.imagePath);
      if (await file.exists()) await file.delete();
      
      // Ricarica la lista aggiornata
      await caricaDati();
    } catch (e) {
      print("Errore durante l'eliminazione: $e");
      _isLoading = false;
      notifyListeners();
    }
  }
}