import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progetto_finale/Helpers/notiefier.dart';
import 'package:progetto_finale/home_view.dart';
import 'package:provider/provider.dart';

class HttpHelper {
  static const String Url = "http://10.0.2.2/armadio/";
  void eseguiLogin(BuildContext  context ,String nome,String password,bool isregistrazione) async {
    String modo="";
    if (isregistrazione) {
      modo ="registrazione";
    }else{modo ="autenticazione";}
    print(modo);
    final response = await http.post(
      Uri.parse(Url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "azione": modo,
        "nome": nome,
        "password": password
      }),
    );
    final codice = response.statusCode;
    final body = jsonDecode(response.body);
    final code = body['message'];
    print(response.body);
    print(code);
    if (codice == 200) {
  final armadioNotifier = Provider.of<ArmadioNotifier>(context, listen: false);
  armadioNotifier.impostaUtente(nome);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomeView(nomeutente: nome),
    ),
  );
}else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Errore'),
          content: Text('Codice: $code'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  Future<String> rimuoviSfondo(String imagePath) async {
  // leggi il file e convertilo in base64
  final bytes = await File(imagePath).readAsBytes();
  final base64Image = base64Encode(bytes);

  final response = await http.post(
    Uri.parse(Url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "azione": "rimuoviSfondo",
      "immagine": base64Image,
    }),
  );
  
  final body = jsonDecode(response.body);
  return body['immagine']; 
}
void cancellaProfilo(){

}
}