// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class Mycard extends StatefulWidget {
   Color? colore;
  String? numero;
   String? seme;
  Mycard({
    this.colore,
    this.numero,
    this.seme,
  });

  @override
  CardState createState() => CardState();
}

class CardState extends State<Mycard> {
  void setvariabili(Color c,String n, String s){
    setState(() {
     widget.colore=c;
    widget.numero=n;
    widget.seme=s; 
    });
  }
  void abbo (c,n,s){
    setvariabili(c, n, s);
  }
  bool selezionato = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: 
          () {
              setState(() {
                selezionato = !selezionato;
              });
            }
          ,
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 122,
          width: 63,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: selezionato ? Colors.yellow : Colors.white,
              width: 5,
            ),
          ),
          child: widget.numero != null && widget.seme != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.numero!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.colore ?? Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.seme!,
                      style: TextStyle(
                        fontSize: 32,
                        color: widget.colore ?? Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    
                  ],
                )
              : const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}