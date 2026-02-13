import 'package:flutter/material.dart';
import 'dart:math';
class Todo {
  int ?id;
  Todo({required this.name, required this.checked,required this.contid});
  final String name;
  bool checked;
  final int contid;
}

class Contenitore {
  Contenitore({
    required this.id,
    required this.argomento,
    required this.colore,
    List<Todo>? todos,
  }) : todos = todos ?? [];
  final int id;
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
