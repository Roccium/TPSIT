import 'package:get/get.dart';

var controller = Get.put(Controller());

class Controller extends GetxController {
  var mano = <CartaData>[].obs;
  int getNumeroCarteSelezionate() {
    return mano.where((carta) => carta.selezionata.value).length;
  }
    List<CartaData> getCarteSelezionate() {
    return mano.where((carta) => carta.selezionata.value).toList();
  }
    List<int> getIndiciCarteSelezionate() {
    List<int> indici = [];
    for (int i = 0; i < mano.length; i++) {
      if (mano[i].selezionata.value) {
        indici.add(i);
      }
    }
    return indici;
  }
  void deselezionaTutte() {
    for (var carta in mano) {
      carta.selezionata.value = false;
    }
  }
}

class CartaData {
  String numero;
  String seme;
  bool colore; 
  var selezionata = false.obs; 
  CartaData(this.numero, this.seme, this.colore);
}