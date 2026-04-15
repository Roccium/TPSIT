import 'package:flutter/material.dart';
import 'home_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _eseguiLogin(BuildContext context) async {
    // TODO: Implementare chiamata al server PHP
    /*
    var response = await http.post(
      Uri.parse('http://tuoserver.com/api/login.php'),
      body: {'username': _userController.text, 'password': _passController.text}
    );
    if(response.statusCode == 200) { ... }
    */

    // Simulazione login avvenuto con successo
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
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
            ElevatedButton(onPressed: () => _eseguiLogin(context), child: const Text('Entra')),
            TextButton(onPressed: () {}, child: const Text('Nuovo utente? Registrati'))
          ],
        ),
      ),
    );
  }
}