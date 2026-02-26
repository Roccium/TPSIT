## integrazione sqlite e generale del progetto

aggiunta persistenza dei dati tramite sqflite, implementati container
per raggruppare i todo, e esteso il notifier per gestire il caricamento
iniziale dal database.

## Databasecontroller

implementato come singleton per avere una sola istanza del db in tutta
l'app, il database viene aperto la prima volta che viene richiesto e
riutilizzato nelle chiamate successive.

la tabella viene creata con sql diretto:
```sql
CREATE TABLE todo(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  contenuto TEXT NOT NULL,
  statuschecked INTEGER NOT NULL,
  containerdiappartenenza INTEGER NOT NULL
)
```

le operazioni crud sono gestite tramite i metodi della libreria sqflite,
ad esempio per aggiornare lo stato checked di un todo:
```dart
await db.update(
  todo,
  {statuschecked: check},
  where: '$id = ?',
  whereArgs: [todoxupdate.id],
);
```

sono presenti i metodi getAll(), addTask(), modifytask() e deleteTask(),
piu una funzione deleteDatabase() esterna utile in fase di sviluppo
per resettare il db.

## modello dati

sono presenti due classi principali, Todo che tiene il contenuto,
lo stato checked e il riferimento al container tramite contid, e
Contenitore che raggruppa una lista di todo con un colore generato
casualmente tramite randomColor().

i container non vengono salvati sul database, di conseguenza al
riavvio quelli vuoti vengono persi, vengono ricreati solo quelli
che hanno almeno un todo salvato.

## notifier

la classe TodoListNotifier estende ChangeNotifier ed e stata modificata
rispetto alla base del prof per gestire anche il caricamento iniziale.
firstQuery() legge tutti i todo dal db, calcola il numero di container
necessari dal valore massimo di containerdiappartenenza e li ricrea
inserendo i todo nel container corretto:
```dart
void firstQuery() async {
  List<Map<String, dynamic>> result = await _database.getAll();
  int highC = 0;
  for (var i = 0; i < result.length; i++) {
    if (highC < (result[i]["containerdiappartenenza"] as int)) {
      highC = (result[i]["containerdiappartenenza"] as int);
    }
  }
  for (var i = 0; i <= highC; i++) {
    var idC = addContenitore();
    for (var element in result) {
      if (element["containerdiappartenenza"] as int == i) {
        Todo t = Todo(...);
        _container[idC - 1].todos.add(t);
        notifyListeners();
      }
    }
  }
}
```

## interfaccia

la home usa un GridView a due colonne, il tap sullo sfondo aggiunge
un nuovo container vuoto. ogni container mostra i propri todo tramite
il widget ContenitoreItem, e ha un dialog per aggiungere nuovi todo:
```dart
onTap: () {
  notifier.addContenitore();
},
```

firstQuery() viene chiamata una sola volta al primo build tramite
il flag firsttimecheck per evitare chiamate duplicate ad ogni
rebuild del widget
