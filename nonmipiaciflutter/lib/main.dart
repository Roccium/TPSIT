import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<(Color?, Color? background)> customizations =
      <(Color?, Color?)>[
    (null, Colors.grey), // The FAB uses its default for null parameters.
    (null, Colors.yellow),
    (Colors.white, Colors.green),
    (Colors.white, Colors.blue),
    (Colors.white, Colors.red),
  ];
  var sequenza = [
    Random().nextInt(3) + 1,
    Random().nextInt(3) + 1,
    Random().nextInt(3) + 1,
    Random().nextInt(3) + 1
  ];
  void Check() {
    if ( //sequenza[0] == index0 &&
        //sequenza[1] == index1 &&
        //sequenza[2] == index2 &&
        //sequenza[3] == index3
        2 == index0 && 3 == index1 && 2 == index2 && 2 == index3) {
      print('giusto');
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Hai indovinato !'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      );
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        index0 = 0;
        index1 = 0;
        index2 = 0;
        index3 = 0;
      });
      sequenza = [
        Random().nextInt(3) + 1,
        Random().nextInt(3) + 1,
        Random().nextInt(3) + 1,
        Random().nextInt(3) + 1
      ];
    } else {
      print("sbagliato");
    }
  }

  int index0 = 0;
  int index1 = 0;
  int index2 = 0;
  int index3 = 0;
  checkstate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Click Counter'),
      ),
      body: Center(
        child: Row(
          children: [
            FilledButton(
              onPressed: () => setState(() {
                index0 = (index0 + 1) % customizations.length;
              }),
              style: FilledButton.styleFrom(
                  backgroundColor: customizations[index0].$2,
                  fixedSize: const Size(10, 55)),
              child: const Text(''),
            ),
            FilledButton(
              onPressed: () => setState(() {
                index1 = (index1 + 1) % customizations.length;
              }),
              style: FilledButton.styleFrom(
                  backgroundColor: customizations[index1].$2,
                  fixedSize: const Size(10, 55)),
              child: const Text(''),
            ),
            FilledButton(
              onPressed: () => setState(() {
                index2 = (index2 + 1) % customizations.length;
              }),
              style: FilledButton.styleFrom(
                  backgroundColor: customizations[index2].$2,
                  fixedSize: const Size(10, 55)),
              child: const Text(''),
            ),
            FilledButton(
              onPressed: () => setState(() {
                index3 = (index3 + 1) % customizations.length;
              }),
              style: FilledButton.styleFrom(
                  backgroundColor: customizations[index3].$2,
                  fixedSize: const Size(10, 55)),
              child: const Text(''),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Check(), tooltip: 'controlla', child: Text('?')),
    );
  }
}
