import 'package:flutter/material.dart';
import 'dart:math';

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class Contenitore {
  Contenitore({
    required this.argomento,
    required this.colore,
    List<Todo>? todos,
  }) : todos = todos ?? [];

  final String argomento;
  final Color colore;
  final List<Todo> todos;
}

Color randomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(200) + 56,
    random.nextInt(200) + 56,
    random.nextInt(200) + 56,
  );
}
