import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_view.dart';
class LoginView extends StatelessWidget {
  static const String Url = "http://10.0.2.2/armadio/";
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _eseguiLogin(BuildContext  context ,String nome,String password,bool isregistrazione) async {
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
      print("IL CODICE é 200!!!!!");
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
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
    
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accedi all\'Armadio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => _eseguiLogin(context,_userController.text,_passController.text,false), child: const Text('Entra')),
            TextButton(onPressed: () => _eseguiLogin(context,_userController.text,_passController.text,true), child: const Text('Nuovo utente? Registrati'))
          ],
        ),
      ),
    );
  }
}
