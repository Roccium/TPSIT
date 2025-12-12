import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gioco_poker/homepage.dart';



class Hub extends StatelessWidget {
  Future<void> _connetti(String ip, BuildContext context) async {
  try {
      Socket socket = await Socket.connect(ip, 4567);
      if (context.mounted) { 
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => HomePage(sock: socket),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore di connessione: $e')),
          
        );
      }
    }

  }
  const Hub({super.key});
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: TextField(
              controller:  myController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'IP del Server'),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.transparent,
                  width: 30.0,
                ),
              ),
            ),
            child: ElevatedButton(onPressed: () => _connetti(myController.text,context), child: const Text("Send")),
          )
        ],
      )),
    );
  }
}
