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
    required this.livello,
    required this.argomento,
    List<Immagine>? griglia,
  }) : griglia = griglia ?? [];
  final int livello;
  final String argomento;
  List<Immagine> griglia;
}
