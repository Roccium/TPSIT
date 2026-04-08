import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:progetto_finale/Camera.dart';
import 'package:progetto_finale/notiefier.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
//camera frontale, davanti,grandangolo...
List<CameraDescription> cameras = [];
Future<void> main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ChangeNotifierProvider<ArmadioListNotifier>( 
        create: (_) => ArmadioListNotifier(),            
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
      Future<void> openCamera(BuildContext context) async {
    final cameras = await availableCameras();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraScreen(cameras: cameras),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ArmadioListNotifier>(); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.camera_alt),
          label: const Text('Apri Camera'),
          onPressed: () => openCamera(context), // ✅ passa context qui
        ),
      ),);
  }
}