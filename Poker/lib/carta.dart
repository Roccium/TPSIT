// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class Mycard extends StatefulWidget {
  final Color? colore;
  final String? numero;
  final String? seme;
  final bool interagibile;
  bool vuoleCambiare = false;

  Mycard({
    super.key,
    this.colore,
    this.numero,
    this.seme,
    this.interagibile = true,
  });

  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<Mycard> {
  
  bool selezionato = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.interagibile
          ? () {
              setState(() {
                selezionato = !selezionato;
              });
            }
          : null,
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
            ),
          ),
          child: widget.numero != null && widget.seme != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Numero in alto
                    Text(
                      widget.numero!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.colore ?? Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Seme al centro
                    Text(
                      widget.seme!,
                      style: TextStyle(
                        fontSize: 32,
                        color: widget.colore ?? Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Numero in basso (invertito)
                    Text(
                      widget.numero!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.colore ?? Colors.black,
                      ),
                    ),
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