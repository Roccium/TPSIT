import 'package:flutter/material.dart';
import 'package:progetto_finale/Helpers/http_helper.dart';
class LoginView extends StatelessWidget {
  final HttpHelper http = HttpHelper();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
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
            ElevatedButton(onPressed: () => http.eseguiLogin(context,_userController.text,_passController.text,false), child: const Text('Entra')),
            TextButton(onPressed: () => http.eseguiLogin(context,_userController.text,_passController.text,true), child: const Text('Nuovo utente? Registrati'))
          ],
        ),
      ),
    );
  }
}
void check () {
  
}
