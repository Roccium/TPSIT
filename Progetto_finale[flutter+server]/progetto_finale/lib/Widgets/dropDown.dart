
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:progetto_finale/Helpers/http_helper.dart';
import 'package:progetto_finale/login_view.dart';

  List<String> list = <String>['Profilo', 'Cambia profilo'];
class DropdownMenuprofili extends StatefulWidget {
  const DropdownMenuprofili({super.key,required String nomeProfilo});

  @override
State<DropdownMenuprofili> createState() => _DropdownMenuprofili();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownMenuprofili extends State<DropdownMenuprofili> {
  
  final HttpHelper http = HttpHelper();
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: 170,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(),
      ),
      initialSelection: list.first,
      onSelected: (String? value) {
          if (value == 'Cancella profilo') {
            http.cancellaProfilo();
          }
          if (value == 'Cambia profilo') {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
          }
        
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}