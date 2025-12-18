// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gioco_poker/observer.dart';

class Mycard extends StatelessWidget {
  CartaData cartaData;
  
  Mycard({
    required this.cartaData,
    Color? colore,
    String? numero,
    String? seme,
  });

  @override
  Widget build(BuildContext context) {
    
    List<String> semi = ['♦','♠', '♥', '♣'];
    return Obx(() => GestureDetector(
      onTap: () {
        cartaData.selezionata.value = !cartaData.selezionata.value;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 122,
          width: 63,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: cartaData.selezionata.value ? Colors.yellow : Colors.white,
              width: 5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cartaData.numero,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: cartaData.colore ? Colors.blue :Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Text(
                cartaData.seme=="d"? semi.elementAt(0):cartaData.seme=="p"? semi.elementAt(1):cartaData.seme=="c"? semi.elementAt(2):semi.elementAt(3),
                style: TextStyle(
                  fontSize: 32,
                  color: cartaData.colore ? Colors.red : Colors.blue,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    ));
  }
}