// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gioco_poker/carta.dart';
import 'package:gioco_poker/observer.dart';
import 'package:gioco_poker/retro_carta.dart';

class HomePage extends StatefulWidget {
  Socket sock;
  HomePage({super.key, required this.sock});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CartaData> valoricarte = [];
  List<Mycard> miecarte = [];
  bool possomandare=false;
  bool possorichiedere=true;
  @override
  void initState() {
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
void showAlertDialog(BuildContext context,String s) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();},
  );
  AlertDialog alert = AlertDialog(
    title: Text("Hai $s"),
    content: Text("le tue carte hanno $s contro quelle dell' avversario !"),
    actions: [
      okButton,
    ],
    backgroundColor: s=="vinto"? Colors.green: s=="pareggiato"?Colors.grey:Colors.deepOrangeAccent,
    
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  void gestisciMessaggio(String messaggio) {
    switch (messaggio) {
      case "v":
      showAlertDialog(context,"vinto");
        break;
      case "p":
      showAlertDialog(context,"perso");
        break;
      case "d":
      showAlertDialog(context,"pareggiato");
        break;
      default:
        daimano(messaggio);
    }
  }

  void daimano(String messaggio) {
    List<String> carte = messaggio.split(';');
    for (int j = 0; j < carte.length - 1; j++) {
      List<String> mano = carte.elementAt(j).split(',');
      var card = CartaData(mano[0] , mano[1], (mano[2] == 'true') );

      controller.mano.add(card);


    }
  }

  void richiedeCambio(int numCarte) {
    widget.sock.write("cambio:$numCarte");
  }

  void inviaManoPokere() {
    String manos = controller.mano
        .map((c) => '${c.numero},${c.seme},${c.colore}')
        .join(';');
        
        
    widget.sock.write("controlla:$manos");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff067509),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RetroCard(),
                  RetroCard(),
                  RetroCard(),
                  RetroCard(),
                  RetroCard(),
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
                    child: RetroCard(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
          ElevatedButton(
          onPressed: possorichiedere ? () {
          int numCarteSelezionate = controller.getNumeroCarteSelezionate();
          richiedeCambio(numCarteSelezionate);
          for (var element in controller.getCarteSelezionate()) {
            controller.mano.remove(element);
          }
          setState(() {
              possomandare = true;
              possorichiedere = false;
            });
          } : null,
          child: Text('cambia carte'),
        ),
                ],
              ),
              Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: controller.mano.map((card) => 
                Mycard(cartaData: card)
              ).toList(),
            )),
              ElevatedButton(
                onPressed:possomandare ?(){
                  inviaManoPokere();
                setState(() {
                  possomandare=false;
                });}:null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 255, 181, 69),
                ),
                child: Text(
                  'MOSTRA MANO',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
