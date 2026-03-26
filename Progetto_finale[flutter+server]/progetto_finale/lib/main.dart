import 'package:flutter/material.dart';
import 'package:progetto_finale/notiefier.dart';
import 'package:provider/provider.dart';

void main() {
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

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ArmadioListNotifier>(); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: const Center(
        child: Text('Contenuto'),
      ),
    );
  }
}