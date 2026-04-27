import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'database_helper.dart';
import 'models.dart';

List<CameraDescription> globalCameras = [];

class ArmadioNotifier with ChangeNotifier {
  final _db = DatabaseHelper.istanza;
  bool _isLoading = false;

  final List<String> _categorieFisse = [
    'Cappelli', 'Collane', 'Maglie', 'Cinture', 'Pantaloni', 'Scarpe'
  ];
  
  List<SezioneArmadio> _sezioni = [];
  
  List<Map<String, dynamic>> _widgets = [
    {'id': 'Cappelli',  'dx': 0.0, 'dy': 0.0,   'h': 100.0, 'w': 100.0},
    {'id': 'Collane',   'dx': 0.0, 'dy': 100.0, 'h': 300.0, 'w': 200.0},
    {'id': 'Maglie',    'dx': 0.0, 'dy': 200.0, 'h': 200.0, 'w': 300.0},
    {'id': 'Cinture',   'dx': 0.0, 'dy': 300.0, 'h': 400.0, 'w': 100.0},
    {'id': 'Pantaloni', 'dx': 0.0, 'dy': 400.0, 'h': 100.0, 'w': 100.0},
    {'id': 'Scarpe',    'dx': 0.0, 'dy': 500.0, 'h': 100.0, 'w': 100.0},
  ];

  List<Map<String, dynamic>> get widgets => _widgets;
  List<SezioneArmadio> get sezioni => _sezioni;
  bool get isLoading => _isLoading;

  // aggiorna posizione senza rebuild
  void updateWidgetPosition(String id, double dx, double dy) {
    final index = _widgets.indexWhere((w) => w['id'] == id);
    if (index == -1) return;
    _widgets[index]['dx'] = dx;
    _widgets[index]['dy'] = dy;
  }

  void bringToFront(String id) {
    final index = _widgets.indexWhere((w) => w['id'] == id);
    if (index == -1 || index == _widgets.length - 1) return;
    final temp = _widgets[index];
    _widgets[index] = _widgets[index + 1];
    _widgets[index + 1] = temp;
    notifyListeners();
  }

  void sendToBack(String id) {
    final index = _widgets.indexWhere((w) => w['id'] == id);
    if (index == -1 || index == 0) return;
    final temp = _widgets[index];
    _widgets[index] = _widgets[index - 1];
    _widgets[index - 1] = temp;
    notifyListeners();
  }

  Future<void> caricaDati() async {
    _setLoading(true);
    try {
      final tutti = await _db.getAllCapi();
      Map<String, List<Capo>> mappa = {for (var c in _categorieFisse) c: []};

      for (var capo in tutti) {
        if (mappa.containsKey(capo.categoria)) {
          mappa[capo.categoria]!.add(capo);
        }
      }

      _sezioni = mappa.entries
          .map((e) => SezioneArmadio(titolo: e.key, capi: e.value))
          .toList();
    } catch (e) {
      debugPrint("Load Error: $e");
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> aggiungiCapo(CameraController controller, String categoria) async {
    if (!controller.value.isInitialized) return;
    _setLoading(true);
    try {
      final image = await controller.takePicture();
      final savedPath = await _saveImageLocally(image);
      await _db.insertCapo(Capo(categoria: categoria, imagePath: savedPath));
      await caricaDati();
    } catch (e) {
      debugPrint("Add Error: $e");
      _setLoading(false);
    }
  }

  Future<void> eliminaCapo(Capo capo) async {
    if (capo.id == null) return;
    _setLoading(true);
    try {
      await _db.deleteCapo(capo.id!);
      final file = File(capo.imagePath);
      if (await file.exists()) await file.delete();
      await caricaDati();
    } catch (e) {
      _setLoading(false);
    }
  }

  void setCategoriaCover(String titolo, String path) {
    final index = _sezioni.indexWhere((s) => s.titolo == titolo);
    if (index != -1) {
      _sezioni[index].coverPath = path;
      notifyListeners();
    }
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String> _saveImageLocally(XFile image) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    return await Isolate.run(() async {
      final source = File(image.path);
      final dest = await source.copy(path);
      if (await source.exists()) await source.delete();
      return dest.path;
    });
  }

  
}
