import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'notiefier.dart';
import 'login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inizializziamo la variabile globale definita in notiefier.dart
  globalCameras = await availableCameras();
  
  runApp(
    // Avvolgiamo l'app con ChangeNotifierProvider al posto di ProviderScope
    ChangeNotifierProvider(
      create: (context) => ArmadioNotifier()..caricaDati(), // Carica subito i dati
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
      home: LoginView(),
    );
  }
}