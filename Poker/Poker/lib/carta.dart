import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mycard extends StatefulWidget {
  final colore;
  final numero;
  final seme;
  final interagibile;
  const Mycard(
      {super.key,
      /*required*/ this.colore,
      /*required*/ this.numero,
      /*required*/ this.seme,
      /*required*/ this.interagibile});
  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<Mycard> {
  var selezionato = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 122,
            width: 63,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: selezionato ? Colors.yellow : Colors.white,
                  width: 5,
                )),
          )),
      onTap: () {
        setState(() {
          selezionato = !selezionato;
        });
      },
    );
  }
}
