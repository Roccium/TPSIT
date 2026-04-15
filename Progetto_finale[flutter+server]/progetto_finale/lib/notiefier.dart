import 'dart:io';
import 'dart:async';
import 'dart:isolate'; // AGGIUNTO: Fondamentale per non far laggare l'app
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import '../database_helper.dart'; 
import '../models.dart';          

// --- 1. PROVIDER DELLE FOTOCAMERE (Risolve l'errore nel main!) ---
final camerasProvider = StateProvider<List<CameraDescription>>((ref) => []);

// --- 2. PROVIDER DELL'ARMADIO ---
final armadioProvider = AsyncNotifierProvider<ArmadioNotifier, List<SezioneArmadio>>(
  ArmadioNotifier.new,
);

class ArmadioNotifier extends AsyncNotifier<List<SezioneArmadio>> {
  final _db = DatabaseHelper.istanza;
  final List<String> _categorieFisse = ['Maglie', 'Pantaloni', 'Scarpe'];

  @override
  FutureOr<List<SezioneArmadio>> build() async {
    return _caricaERaggruppa();
  }

  Future<List<SezioneArmadio>> _caricaERaggruppa() async {
    final tutti = await _db.getAllCapi();
    
    // Creiamo la mappa delle sezioni
    Map<String, List<Capo>> mappa = { for (var c in _categorieFisse) c: [] };

    for (var capo in tutti) {
      if (mappa.containsKey(capo.categoria)) {
        mappa[capo.categoria]!.add(capo);
      }
    }

    return mappa.entries.map((e) => SezioneArmadio(titolo: e.key, capi: e.value)).toList();
  }

  // --- AZIONI (CRUD) ---

  // Azione scatto: aggiorna l'intero stato dell'armadio
  Future<void> aggiungiCapo(CameraController controller, String categoria) async {
    if (!controller.value.isInitialized) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final image = await controller.takePicture();
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // AGGIUNTO: Isolate.run per spostare la foto in background senza laggare
      final savedPath = await Isolate.run(() async {
        final source = File(image.path);
        final destination = await source.copy(path);
        if (await source.exists()) await source.delete(); // Pulisce la cache
        return destination.path;
      });

      // Salva nel database SQLite
      await _db.insertCapo(Capo(categoria: categoria, imagePath: savedPath));
      
      return _caricaERaggruppa();
    });
  }

  // AGGIUNTO: Metodo per eliminare un capo (Database + File)
  Future<void> eliminaCapo(Capo capo) async {
    if (capo.id == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // 1. Elimina dal Database
      await _db.deleteCapo(capo.id!);
      
      // 2. Elimina il file fisico per liberare memoria
      final file = File(capo.imagePath);
      if (await file.exists()) await file.delete();
      
      return _caricaERaggruppa();
    });
  }
}