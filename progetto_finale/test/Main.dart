import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifier.dart';
import 'model.dart';
import 'widget.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'outfit_check',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 229, 7, 207),
        ),
      ),
      home: ChangeNotifierProvider<ArmadioNotifier>(
        create: (notifier) => ArmadioNotifier(),
        child: const MyHomePage(title: 'outfit_check'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ← serve questo
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('La mia lista'),
              floating: true,
              snap: true,
            ),
            SliverList.separated(
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(
                title: Text('ListTile with red background'),
                textColor: Color.fromARGB(
                  255,
                  random.nextInt(200) + 56,
                  random.nextInt(200) + 56,
                  random.nextInt(200) + 56,
                ),
              ),
              separatorBuilder: (context, index) => Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
