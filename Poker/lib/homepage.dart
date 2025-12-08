// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poker/carta.dart';
import 'package:poker/retro_carta.dart';

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
  List<CartaData> mieCarte = [];
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
    if (messaggio == "start") {
      //mettere popup
    } else if (messaggio == "v") {
      //mettere popup
    } else if (messaggio == "p") {
      //mettere popup
    } else if (messaggio == "d") {
      //mettere popup
    } else {
      build(context);
     daiCarte(messaggio);
    }
  }
  daiCarte(String carte){
      List<CartaData> mano = [];
      List<String> car = carte.split(';');
      for (var element in car) {
        List<String> parti = element.split(',');
        int numero = int.parse(parti[0]);
        String seme = parti[1];
        bool colore = parti[2] == 'true';
        mano.add(CartaData(numero, seme, colore));
      print(mano);
      }
  setState(() {
    mieCarte=mano;
  });
  }
  
 void richiedeCambio(int numCarte) {
    widget.sock.write(numCarte.toString());
  }

  void inviaManoPokere() {
    String mano = mieCarte
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                  transform: Matrix4.identity()
                    ..translate(75.0, -30.0, 0.0)
                    ..rotateZ(0.55),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(40.0, -10.0, 0.0)
                    ..rotateZ(0.30),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-40.0, 3.0, 0.0)
                    ..rotateZ(-0.30),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-70.0, -5.0, 0.0)
                    ..rotateZ(-0.45),
                  child: RetroCard()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                    top: 0,
                    right: 15,
                    left: 15,
                  ),
                  child: RetroCard()),
              Container(
                child: Mycard(interagibile: false,),
              ),
              Container(
                width: 90,
              )
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
                  child: Mycard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-5.0, 15.0, 0.0)
                    ..rotateZ(-0.25),
                  child: Mycard()),
              Mycard(),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(5.0, 3.0, 0.0)
                    ..rotateZ(0.25),
                  child: Mycard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(10.0, 21.0, 0.0)
                    ..rotateZ(0.45),
                  child: Mycard()),

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