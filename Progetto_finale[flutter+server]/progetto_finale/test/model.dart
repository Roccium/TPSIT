import 'package:flutter/material.dart';

class Lista {
  Lista({
    required this.livello,
    required this.vestiti,
    required this.id,
    required this.tipoVestiti,
  });
  final int livello;
  final List<Item> vestiti;
  final int id;
  final String tipoVestiti;
}

class Item {
  Item({
    required this.linkToImage,
    required this.tipoVestito,
    required this.colori,
    required this.qualita,
  });
  final String linkToImage;
  final String tipoVestito;
  final List<Colors> colori;
  final List<Propieta> qualita;
}

class Propieta {
  Propieta({required this.name, required this.desrizione});
  final String name;
  final String desrizione;
}
