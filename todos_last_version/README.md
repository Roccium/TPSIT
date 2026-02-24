# todos_last_version

progetto basato sul todo dato dal prof, integrazione di sqllite come database per salvare i dati in locale

## Introduzione 

Ho lavorato sulla consegna e con la base dataci dal prof morettin del am032_todo_list da cui ho aggiunto parti a discrezione persponale.
Uno dei punti chiave di questa consegna è stata l'implementazione del database attraverso sqllite per gestire il salvataggio dei dati inseriti dall utente, alcuni comandi come quello di creazione del database sono linea di sql dirette mentre le operazioni sul db sono state fatte attraverso i mezzi dati dalla libreria.
 ```sh
db.execute('''
          CREATE TABLE todo(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          contenuto TEXT NOT NULL,
          statuschecked INTEGER NOT NULL,
          containerdiappartenenza INTEGER NOT NULL
          )
          ''');
```
 ```sh
  void modifytask(Todo todoxupdate) async{
    final db = await database();
     
    var check =(todoxupdate.checked == false) ? "0" : "1";
      
    await db.update(
    todo, 
    {statuschecked: check},
    where: '$id = ?',
    whereArgs: [todoxupdate.id],
    );
    
  }
```

## classi

per gestire lo stato del programma ho usato la classe notifiar provveduta dal prof con pesanti modifiche ora gestisce anche la prima queery del programma e l'inserimento dei todo dentro gli appositi container, propio su questo ho aggiunto la classe conteiner per tenere traccia di dove i todo dovevano essere inseriti rispetto allo spazio circostante, i contenitori sono distinti dai todo quindi se ne possono creare quanti se ne vogliano senza creare nessun todo,ma visto che solo i todo vengono salvati sul database tutti i conteiner vuoti una volta che si riavvia il programma verranno cancellati.


