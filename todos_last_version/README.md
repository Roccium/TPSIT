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
