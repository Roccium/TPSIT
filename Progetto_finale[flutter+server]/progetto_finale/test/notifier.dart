import 'package:flutter/widgets.dart';
import 'model.dart';

class ArmadioNotifier with ChangeNotifier {
  
  final liste = <Lista>[];
    void aggiungiLista() {
    
    liste.add(
      Lista(
        id:0,
        livello:0,
        vestiti: List.empty(),
        tipoVestiti: ""
      ),
    );
    notifyListeners();
  }

void aggiungivestitoAunaLista(Lista list, String name,bool check) {
    var t =Item(linkToImage: "", tipoVestito: "", colori: List.empty(), qualita: List.empty()) ;
     list.vestiti.add(t);
    notifyListeners();
  }
}
