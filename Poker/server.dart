import 'dart:core';
import 'dart:io';
import 'dart:math';

ServerSocket? server;
List<Giocatore> partita = [];
List<Carte> mazzo = [];
List<String> semi = ['♦','♠', '♥', '♣'];
Random random = Random();
int stage = 0;

class Carte {
  int numero;
  String seme;
  bool colore;
  Carte(this.seme, this.numero, this.colore);
}

class Giocatore {
  List<int> valoremano= [];
  Socket _socket;
  String _address;
  int _port;
  List<String> mano= [];
  
      Giocatore(Socket s)
          : _socket = s,
            _address = s.remoteAddress.address,
            _port = s.remotePort {
        _socket.listen(messageHandler,
            onError: errorHandler,
            onDone: finishedHandler);
      }

          void messageHandler(dynamic data) {
            //switch che prende da stage
            String message = String.fromCharCodes(data as List<int>).trim();
            if(stage<=3){
            _socket.write(dealHand(int.parse(message)));
              stage++;
            }
            else{
              final veduta = message.split(";");
                veduta.removeWhere((element) => element.isEmpty); // Rimuovi elementi vuoti
                mano = veduta;
              valoremano=statoMano(mano);
              checkWin();
            }
            }

                      void errorHandler(error) {
                        print('${_address}:${_port} Error: $error');
                        removeClient(this);
                        _socket.close();
                      }

                      void finishedHandler() {
                        print('${_address}:${_port} lascia la partita');
                        removeClient(this);
                        _socket.close();
                      }

                      void write(String message) {
                        _socket.write(message);
                      }
}


void startGame() {
  for (Giocatore c in partita) {
    c.write("start\n");
  }
  // Crea il mazzo
  for (int i = 1; i <= 13; i++) {
    for (int j = 0; j < 4; j++) {
      Carte c = Carte(semi.elementAt(j), i, (j > 1));
      mazzo.add(c);
    }
  }
  // Distribuisci le carte
  for (Giocatore c in partita) {
    c.write(dealHand(5));
    stage++;
  }
}

String dealHand(int n) {
  String deal="";
  for (int k = 0; k < n; k++) {
    int s = random.nextInt(mazzo.length);
    Carte carta = mazzo.elementAt(s);
    //deal.add('${carta.numero},${carta.seme},${carta.colore}');
    deal = deal + '${carta.numero},${carta.seme},${carta.colore};';
    mazzo.removeAt(s);
  }
  return deal;
}


void checkWin(){
  Socket socket1= partita.elementAt(0)._socket;
  Socket socket2 = partita.elementAt(1)._socket;
  for (Giocatore c in partita) {
    if (c.valoremano.isEmpty) {
      return ;
    }
  }
  int carte1 = partita.elementAt(0).valoremano.elementAt(0);
  int highcard1 = partita.elementAt(0).valoremano.elementAt(1);
  int carte2=partita.elementAt(1).valoremano.elementAt(0);
  int highcard2 = partita.elementAt(1).valoremano.elementAt(1);
  if (carte1==carte2) {
    if (highcard1>highcard2) {
      socket1.write("v");
      socket2.write("p");
    }
    else if (highcard2>highcard1) {
      socket2.write("v");
      socket1.write("p");
    }
    else{
        socket1.write("d");
      socket2.write("d");
    }
  }
  else{
      if (carte1>carte2) {
        socket1.write("v");
      socket2.write("p");
      }
      else{
        socket2.write("v");
      socket1.write("p");
      }
  }
}


List<int> statoMano(List<String> mG){
  List<int> valore = [];
  List<Carte> m = [];


  for (var element in mG) {
    List<String> c = [];
    c =element.split(",");
    m.add(Carte(
      c.elementAt(1), int.parse(c.elementAt(0)), bool.parse(c.elementAt(2))
      ));
  }


  bool semeuguale= true;
  Carte test = m.first;
  for (var element in m) {
    semeuguale=semeuguale && (test.seme ==  element.seme);
    valore.add(element.numero);
  }
  
  valore.sort();


  bool scala = true;
  int previusval = valore.first-1;
    for (var val in valore) {
    scala = scala && (previusval == val-1);
    previusval = val;
  }
  if( scala == true && semeuguale == true){
    return [100,valore.last];
  }
  if (scala == false && semeuguale == true) {
    return [17,valore.last];
  }
  if (scala == true && semeuguale == false) {
    return [16,valore.last];
  }
  else{
      Map<int,int> doppioni = {};
      for (var element in valore) {
        if(!doppioni.containsKey(element)) {
        doppioni[element] = 1;
      } else 
      {
        doppioni[element]=(doppioni[element] ?? 0) + 1;
      }
      };
      List<MapEntry<int, int>> mappadiscendente = doppioni.entries.toList();
      mappadiscendente.sort((a, b) => b.value.compareTo(a.value));

  int maxOccorrenze = mappadiscendente.first.value;
  int cartaPiuAlta = mappadiscendente.first.key;
  
  if (maxOccorrenze == 4) {
    return [40, cartaPiuAlta];
  }
  
  if (maxOccorrenze == 3) {
    if (mappadiscendente.length == 2) {
      return [20, cartaPiuAlta];
    } else {
      return [15, cartaPiuAlta];
    }
  }
  
  if (maxOccorrenze == 2) {
    if (mappadiscendente.length == 3) {
      int cartaPiuAltaCoppia = mappadiscendente[0].key > mappadiscendente[1].key 
          ? mappadiscendente[0].key 
          : mappadiscendente[1].key;
      return [10, cartaPiuAltaCoppia];
    } else {
      return [5, cartaPiuAlta];
    }
  }
      
  }
  
  return [0,valore.last];
}

void startServer() {
  ServerSocket.bind(InternetAddress.anyIPv4, 4567)
      .then((ServerSocket socket) {
    server = socket;
    server!.listen((client) {
      handleConnection(client);
    });
    print('Server in ascolto su porta 4567...');
  });
}

void handleConnection(Socket client) {
  print('Connection from '
      '${client.remoteAddress.address}:${client.remotePort}');

  partita.add(Giocatore(client));
  if (partita.length == 2) {
    startGame();
  }
}

void removeClient(Giocatore client) {
  partita.remove(client);
}
void main() {
  startServer();
}


//ascoltare sulla porta 4567
//quando entra il secondo giocatore iniziare il gioco
//  -mandare un messaggio che il gioco è iniziato
//  -mandare cinque carte randomiche diverse a ciascuno
//  -aspettare che carte vogliono cambiare
//  -ridargli delle carte
//  -controllare chi ha vinto
//  -mandare il messaggio al vincitore/perdente
