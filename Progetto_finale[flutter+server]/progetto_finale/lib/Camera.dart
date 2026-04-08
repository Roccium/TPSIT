import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController? _controller;
  int _selectedCamera = 0; // 0 = posteriore, 1 = anteriore
  XFile? _lastPhoto;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera(widget.cameras[_selectedCamera]);
  }

  // Inizializza il controller
  Future<void> _initCamera(CameraDescription description) async {
    final controller = CameraController(
      description,
      ResolutionPreset.high,  // low / medium / high / veryHigh / ultraHigh / max
      enableAudio: false,
    );

    _controller = controller;

    try {
      await controller.initialize();
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint('Errore inizializzazione camera: $e');
    }
  }

  // Scatta una foto
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile photo = await _controller!.takePicture();
      setState(() => _lastPhoto = photo);
    } catch (e) {
      debugPrint('Errore scatto foto: $e');
    }
  }

  // Cambia tra fotocamera anteriore e posteriore
  void _switchCamera() {
    _selectedCamera = _selectedCamera == 0 ? 1 : 0;
    _controller?.dispose();
    _initCamera(widget.cameras[_selectedCamera]);
  }

  // Gestisce pause/resume dell'app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera(widget.cameras[_selectedCamera]);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // Preview camera
          if (_isInitialized && _controller != null)
            SizedBox.expand(
              child: CameraPreview(_controller!),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Ultima foto scattata (in basso a sinistra)
          if (_lastPhoto != null)
            Positioned(
              bottom: 32,
              left: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(_lastPhoto!.path),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          // Bottone scatto (centro basso)
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),

          // Bottone switch camera (in alto a destra)
          Positioned(
            top: 48,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 30),
              onPressed: _switchCamera,
            ),
          ),
        ],
      ),
    );
  }
}