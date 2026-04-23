import 'dart:io';
import 'dart:async';
import 'dart:isolate'; 
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import '../database_helper.dart'; 
import '../models.dart';          

List<CameraDescription> globalCameras = [];

class ArmadioNotifier with ChangeNotifier {
  final _db = DatabaseHelper.istanza;
  final List<String> _categorieFisse = [
    'Cappelli', 'Collane', 'Maglie', 'Cinture', 'Pantaloni', 'Scarpe'
  ];

  // --- NUOVO ---
  int _sezioniVisibili = 3;

  List<SezioneArmadio> _sezioni = [];
  bool _isLoading = true;

  // Getters esistenti
  List<SezioneArmadio> get sezioni => _sezioni;
  bool get isLoading => _isLoading;

  // --- NUOVI GETTERS ---
  List<SezioneArmadio> get sezioniVisibili =>
      _sezioni.take(_sezioniVisibili).toList();

  bool get haSezioniNascoste => _sezioniVisibili < _sezioni.length;

  // ------------------------------------------------
  // CARICA DATI — identico al tuo originale
  // ------------------------------------------------
  Future<void> caricaDati() async {
    _isLoading = true;
    notifyListeners();

    try {
      final tutti = await _db.getAllCapi();
      
      Map<String, List<Capo>> mappa = { for (var c in _categorieFisse) c: [] };

      for (var capo in tutti) {
        if (mappa.containsKey(capo.categoria)) {
          mappa[capo.categoria]!.add(capo);
        }
      }

      _sezioni = mappa.entries
          .map((e) => SezioneArmadio(titolo: e.key, capi: e.value))
          .toList();
      
    } catch (e) {
      print("Errore nel caricamento dati: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void setCategoriaCover(String titoloSezione, String imagePath) {
  // 1. Cerchiamo l'indice della sezione corretta
  final index = _sezioni.indexWhere((s) => s.titolo == titoloSezione);
  
  if (index != -1) {
    // 2. Aggiorniamo il percorso della copertina
    _sezioni[index].coverPath = imagePath;
    
    // 3. Fondamentale: notifichiamo la UI del cambiamento
    notifyListeners();
    
    // Nota: Per rendere questa scelta permanente al riavvio dell'app,
    // in futuro dovrai salvare imagePath nel database o nelle SharedPreferences.
    debugPrint("Copertina aggiornata per $titoloSezione: $imagePath");
  }
}
  // ------------------------------------------------
  // AGGIUNGI CAPO — identico al tuo originale
  // ------------------------------------------------
  Future<void> aggiungiCapo(CameraController controller, String categoria) async {
    if (!controller.value.isInitialized) return;

    _isLoading = true;
    notifyListeners();

    try {
      final image = await controller.takePicture();
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      final savedPath = await Isolate.run(() async {
        final source = File(image.path);
        final destination = await source.copy(path);
        if (await source.exists()) await source.delete();
        return destination.path;
      });

      await _db.insertCapo(Capo(categoria: categoria, imagePath: savedPath));
      await caricaDati(); 
    } catch (e) {
      print("Errore durante l'aggiunta del capo: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // ------------------------------------------------
  // ELIMINA CAPO — identico al tuo originale
  // ------------------------------------------------
  Future<void> eliminaCapo(Capo capo) async {
    if (capo.id == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _db.deleteCapo(capo.id!);
      
      final file = File(capo.imagePath);
      if (await file.exists()) await file.delete();
      
      await caricaDati();
    } catch (e) {
      print("Errore durante l'eliminazione: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // ------------------------------------------------
  // NUOVO: rivela la prossima sezione nascosta
  // ------------------------------------------------
  void rivelaProssimaSezione() {
    if (haSezioniNascoste) {
      _sezioniVisibili++;
      notifyListeners();
    }
  }
}