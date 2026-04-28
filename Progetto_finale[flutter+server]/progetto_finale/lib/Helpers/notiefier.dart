import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'database_helper.dart';
import '../models.dart';

List<CameraDescription> globalCameras = [];

class ArmadioNotifier with ChangeNotifier {
  final _db = DatabaseHelper.istanza;
  bool _isLoading = false;
  String nomeutente = "";
  final List<String> _categorieFisse = [
    'Cappelli', 'Collane', 'Maglie', 'Cinture', 'Pantaloni', 'Scarpe','Felpa','Giacca'
  ];
  
  List<SezioneArmadio> _sezioni = [];
  List<Map<String, dynamic>> _widgets = [
    {'id': 'Pantaloni', 'dx': 200.0-275/2, 'dy': 1000.0/3, 'h': 375.0, 'w': 275.0},
    {'id': 'Giacca',    'dx': 200.0-350/2, 'dy': 1000.0/10, 'h': 350.0, 'w': 350.0},
    {'id': 'Felpa',    'dx': 200.0-350/2, 'dy': 1000.0/10, 'h': 355.0, 'w': 355.0},
    {'id': 'Maglie',    'dx': 200.0-350/2, 'dy': 1000.0/10, 'h': 360.0, 'w': 360.0},
    {'id': 'Cinture',   'dx': 200.0-300/2, 'dy': 1000.0/2.5, 'h': 50.0, 'w': 300.0},
    {'id': 'Scarpe',    'dx': 200.0-325/2, 'dy': 1000.0/1.5, 'h': 100.0, 'w': 325.0},
    {'id': 'Cappelli',  'dx': 200.0-150/2, 'dy': 0.0,   'h': 100.0, 'w': 150.0},
    {'id': 'Collane',   'dx': 200.0-200/2, 'dy': 1000.0/20, 'h': 275.0, 'w': 200.0},
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
  void _setnome(String val) {
    nomeutente = val;
    notifyListeners();
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
