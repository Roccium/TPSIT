import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'notiefier.dart';
import 'login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globalCameras = await availableCameras();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => ArmadioNotifier()..caricaDati(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Armadio Online',
      //cambiare e mettere da costanti.dart
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginView(),
    );
  }
}