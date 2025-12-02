import 'package:flutter/material.dart';
import 'package:poker/homepage.dart';

class Hub extends StatelessWidget {
  const Hub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: const TextField(
              cursorWidth: 10,
              decoration: InputDecoration(
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
            child: ElevatedButton(
              child: const Text('Prova A Connettersi'),
              onPressed: () {
                // QUI avviene la magia
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
