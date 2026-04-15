import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'notiefier.dart';

// --- 1. SCHERMATA DI LOGIN ---
class LoginView extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accesso Armadio')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Chiamata HTTP login.php (commentata nel controller)
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
              }, 
              child: const Text('Accedi')
            ),
            TextButton(onPressed: () {}, child: const Text('Crea un account'))
          ],
        ),
      ),
    );
  }
}

// --- 2. SCHERMATA PRINCIPALE (HOME) ---
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Il Mio Armadio')),
      body: ListView(
        children: const [
          CategoriaRow(titolo: 'Maglie'),
          CategoriaRow(titolo: 'Pantaloni'),
          CategoriaRow(titolo: 'Scarpe'),
        ],
      ),
    );
  }
}

// --- 3. RIGA SCROLLABILE PER CATEGORIA ---
class CategoriaRow extends ConsumerWidget {
  final String titolo;
  const CategoriaRow({Key? key, required this.titolo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Il widget ascolta il controller esterno ref.read(armadioProvider.notifier)
    final capi = ref.watch(
  armadioProvider.select((state) => state[titolo] ?? [])
);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(titolo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: capi.length + 1, // Elementi salvati + tasto "+"
            itemBuilder: (context, index) {
              if (index == capi.length) {
                // Widget del tasto "+" per aggiungere
                return _buildAddButton(context, titolo);
              }
              // Widget dell'anteprima immagine
              return _buildImageCard(capi[index].imagePath);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context, String cat) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraView(categoria: cat))),
      child: Container(
        width: 100,
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[400]!, width: 1),
        ),
        child: const Icon(Icons.add_a_photo, size: 35, color: Colors.grey),
      ),
    );
  }

  Widget _buildImageCard(String path) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: FileImage(File(path)), fit: BoxFit.cover),
      ),
    );
  }
}

// --- 4. SCHERMATA FOTOCAMERA (CAMERAX) ---
class CameraView extends ConsumerStatefulWidget {
  final String categoria;
  const CameraView({Key? key, required this.categoria}) : super(key: key);

  @override
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  void _initCamera() async {
    final cameras = ref.read(camerasProvider);
    if (cameras.isEmpty) return;
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Positioned(
            bottom: 40,
            left: 0, right: 0,
            child: Center(
              child: FloatingActionButton(
                child: const Icon(Icons.camera),
                onPressed: () async {
                  // Il controller esterno gestisce logica e database
                  await ref.read(armadioProvider.notifier).aggiungiCapo(_controller!, widget.categoria);
                  if (mounted) Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}