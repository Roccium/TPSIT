
Poker:
 il gioco poker in dart si compone di due elementi :
    -il Server{
    dove risiede il gamestate
    e dove con I ServerSocket si crea la stanza con le classi Giocatori
    }
    _il Client{
      il client aspetta che si inserisca l'ip necessario per connettersi al server, 
      se la connessione va a buon fine si passa alla schermata della partita
      dove il server invia una Stringa per la creazione della Dealing Hand del tipo "'seme','numero','nero o roso';...
      e risponde con il numero di carte che vuole cambiare, e il server rispondera con un altra stringa contenente le nuove carte
      infine si manda la mano al server che la controlla e ritorna v,p,d per vincita perdita o draw;
    }
