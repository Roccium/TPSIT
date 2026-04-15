import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'notiefier.dart';
import 'login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  
  runApp(
    ProviderScope(
      overrides: [
        camerasProvider.overrideWith((ref) => cameras),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armadio Online',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginView(), // Auth Wrapper Base
    );
  }
}