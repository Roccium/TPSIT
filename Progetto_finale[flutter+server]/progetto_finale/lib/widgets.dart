import 'package:flutter/material.dart';
import 'package:progetto_finale/models.dart';

class Contenitore extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Row();//da vedere cosa mettere
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.immagine,
    required this.onDelete,
    required this.onToggle,
    super.key,
  });

  final Immagine immagine;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row();
    //return Image(image: FileImage(File('/path/to/file.jpg')));
  }
}