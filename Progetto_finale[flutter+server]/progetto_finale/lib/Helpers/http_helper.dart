import 'dart:convert';
import 'notiefier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progetto_finale/home_view.dart';

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
    if(codice == 200) {
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeView(nomeutente: nome,)),
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
}