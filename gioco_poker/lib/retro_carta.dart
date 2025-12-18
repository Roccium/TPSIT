import 'package:flutter/material.dart';

class RetroCard extends StatefulWidget {
  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<RetroCard> {
  Color colore = Colors.white;
  bool toccato = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              child: Container(
            height: 110,
            width: 60,
            child: Image.asset('lib/immagini/carta2.jpg', fit: BoxFit.fitHeight),
          ))),
    );
  }
}
