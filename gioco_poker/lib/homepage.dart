// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gioco_poker/carta.dart';
import 'package:gioco_poker/retro_carta.dart';
class CartaData {
  final int numero;
  final String seme;
  final bool colore; // true = nero, false = rosso

  CartaData(this.numero, this.seme, this.colore);
}

class HomePage extends StatefulWidget {
  Socket sock;
  HomePage( {super.key, required this.sock});
    
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
List<CartaData> valoricarte = [];
final miecarte = List<Mycard>.filled(5,Mycard(colore: Colors.amber,numero: "7",seme: "@",));
  @override
  void initstate(){
      super.initState();
      ascoltaServer();
  }

  void ascoltaServer() {
    widget.sock.listen(
      (data) {
        String messaggio = String.fromCharCodes(data).trim();
        
        gestisciMessaggio(messaggio);
      },
      onError: (error) {
        print('Errore socket: $error');
       
      },
      onDone: () {
        print('Connessione chiusa');
        
      },
    );
  }
  void gestisciMessaggio(String messaggio) {
    switch (messaggio) {
      case "start":
        
        break;
      case "v":
        
        break;
      case "p":
        
        break;
      case "d":
        
        break;
      default:
      List<String> car = messaggio.split(';');
      
      for (var element in car) {
        for (var carte in miecarte) {
          List<String> parti = element.split(',');
       // carte.se              ;
        setState(() {
          
       
        carte.numero = (parti[0]);
        carte.seme = parti[1];
        carte.colore = parti[2] == 'true' ? Colors.red:Colors.blue;
         });}
      }
    }
    
  }
 void richiedeCambio(int numCarte) {
    widget.sock.write(numCarte.toString());
  }

  void inviaManoPokere() {
    String mano = valoricarte
        .map((c) => '${c.numero},${c.seme},${c.colore}')
        .join(';');
    widget.sock.write(mano);
    
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff067509),
      body: Center(
          child: Container(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            RetroCard(),
            RetroCard(),
            RetroCard(),
            RetroCard(),
            RetroCard()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                    top: 0,
                    right: 15,
                    left: 15,
                  ),
                  child: RetroCard()),
            ],
          ),
          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => richiedeCambio(0),
                      child: Text('Non cambio'),
                    ),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-5.0, 46.0, 0.0)
                    ..rotateZ(-0.45),
                  child: miecarte.elementAt(0)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-5.0, 15.0, 0.0)
                    ..rotateZ(-0.25),
                  child: miecarte.elementAt(1)),
              miecarte.elementAt(2),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(5.0, 3.0, 0.0)
                    ..rotateZ(0.25),
                  child: miecarte.elementAt(3)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(10.0, 21.0, 0.0)
                    ..rotateZ(0.45),
                  child: miecarte.elementAt(4)),

            ],
          ),
           ElevatedButton(
                  onPressed: inviaManoPokere,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(
                    'MOSTRA MANO',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
        ]),
      )),
    );
  }
}