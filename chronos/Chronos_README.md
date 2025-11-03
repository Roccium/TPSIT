# chronos

un nuovo progetto flutter con scadenza il 5/11/25, dove si mettono alla prova la conoscenza degli stream e delle facoltà di dart

## Per iniziare

La consegna richiedeva l'esistenza di due stream controllati da altrettanti streamController : in questo caso ticker e orologio.
lo stream di ticker e orologio sono connessi da una Streamsubscription "pipe" che ascoltando lo stream di tick per ogni volta che lo stream si aggiorna va a aggiungere al sink di orologio l'evento di ticker, ma solo se orologio non è flagged come paused
## START STOP RESET
  per, come dato nella consegna, implementare un bottone che cicli tra start stop e reset sono andato a creare cancellare l'oggetto timer chiamato tick che è alla base degli eventi per i due stream bloccando o avviando ticker, per il reset invece ho fermato tick, 
  controllando se orologio era paused o no e rimettere sia i bottoni nello stato originario sia la variabile millesecondi(variabile interna di ticker che tiene conto di quanti millisecondi sono passati) a 0,
  ## PAUSE AND RESUME
  per fermare e riavviare lo stopwatch ho fatto si che nel pipe i valori venivano passati solo se una variabile "paused" era falsa, cosi nel caso che fosse vera i dati non verrebbero passati da uno stream all altro(per evitare che ticker continuasse a produrre dati bufferidazzondoli ho contemporaneamente dato start() o stop() )

  ## PROBLEMI VARI
  diversi tra cui l'incosapevolezza dell'esistenza di initState(),streamBuilder() ...
