import 'dart:core';
import 'package:flutter/material.dart';

class Immagine {
  Immagine({required this.id,required this.link,required this.propieta, required  this.colori});
  final int id;
  final String link;
  List<String> propieta;
  final List<Colors> colori;
}

class Contenitore {
  Contenitore({
    required this.id,
    required this.argomento,
    List<Todo>? todos,
  }) : todos = todos ?? [];
  final int id;
  final String argomento;
  final List<String> todos;
  final List<L
}
