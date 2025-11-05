# chronos

un nuovo progetto flutter con scadenza il 5/11/25, dove si mettono alla prova la conoscenza degli stream e delle facoltà di dart

## Per iniziare

La consegna richiedeva l'esistenza di due stream controllati da altrettanti streamController : in questo caso ticker e orologio.
lo stream di ticker e orologio sono connessi da una Streamsubscription "pipe" che ascoltando lo stream di tick per ogni volta che lo stream si aggiorna va a aggiungere al sink di orologio l'evento di ticker, ma solo se orologio non è flagged come paused
## START STOP RESET
  per, come dato nella consegna, implementare un bottone che cicli tra start stop e reset sono andato a creare cancellare l'oggetto timer chiamato tick che è alla base degli eventi per i due stream bloccando o avviando ticker, per il reset invece ho fermato tick, 
  controllando se orologio era paused o no e rimettere sia i bottoni nello stato originario sia la variabile millesecondi(variabile interna di ticker che tiene conto di quanti millisecondi sono passati) a 0 che tutte le altre variabili del caso.
  ```
  void startticker() {
    if (!running) {
      setState(() {
        running = true;
        girabile = true;
      });
      tick = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        giri++;

        millisecondi++;
        ticker.sink.add(millisecondi);
      });
    }
  }
 ```
 nel setState di startticker si modificano a true due variabili che governano la possibilita di interagire con due bottoni: il pause e il giro.
 Non avrebbe senso implementari prima dell inizio del timer visto che hanno entrambi all interno delle azioni che vanno a modificare o osservare azione del ticker il quale inizia ad avere eventi solo dopo l'azione
 start.
  ## PAUSE AND RESUME
  per fermare e riavviare lo stopwatch ho fatto si che nel pipe i valori venivano passati solo se una variabile "paused" era falsa, cosi nel caso che fosse vera i dati non verrebbero passati da uno stream all altro(per evitare che ticker continuasse a produrre dati bufferidazzondoli ho contemporaneamente dato start() o stop() )
  ```
     void pauseorologio() {
    if (!paused) {
      setState(() {
        girabile = false;
        paused = true;
      });
      stopticker();
    }
  }
  ```
  Invece nel setState di pause (il quale si accede solo se la variabile pause è false, per evitare spiacevoli incovenienti)
  si blocca la possibilita di fare altri giri in quanto questi avrebbe valore 0 e corromperebbero i dati, il paused a true serve come conferma per passare all azione resume e smettere di passare di valore nel pipe tra i due streamController

  ## PROBLEMI VARI
 Ho incontrato diversi promblemi, dovuti quasi tutti dalla mia incosapevolezza del funzionamento degli oggetti dart e la confusione a lavorare con degli Stream, questa difficolta è stata anche in parte artificiale in quanto 
 per questo programma uno stream solo sarebbe bastato e avanzato, ma volendo onorare la consegna se ne sono usati due ha creato problemi per la comunicazione tra essi.