
Poker:
 il gioco poker in dart si compone di due elementi :
 # server {
 void startGame() {
  for (int i = 1; i <= 13; i++) {
    for (int j = 0; j < 4; j++) {
      Carte c = Carte(semi.elementAt(j), i, (j > 1));
      mazzo.add(c);
    }
  }
  for (Giocatore c in partita) {
    c.write(dealHand(5));
  }
}] }
 dove risiede il gamestate
    e la logica,
    dove con I ServerSocket si crea la stanza con le classi Giocatori.
    Si inizia con la fase di aspetto dei giocatori, i quali quando arrviano a due innescano il gioco,
    per prima cosa si crea il mazzo per poi distribuire 5 carte a testa.
    Le carte sono rappresentate da una stringa val1,val2,val3;val1carta2,val2carta2 ... sara poi il compito del client splittarli.
    dentro il server c'è anche la logica per controllare quale mano è vincente tra quelle mandate, uso un sistema di punteggi: quando
    un giocare manda la sua mano finale la analizzo e gli do un punteggio da 5 a 100, e quando sono arrivate entrambe comparo i punteggi
    e vedo chi ha vinto
   
  # client
    _il Client{
      il client aspetta che si inserisca l'ip necessario per connettersi al server, 
      se la connessione va a buon fine si passa alla schermata della partita
      dove il server invia una Stringa per la creazione della Dealing Hand del tipo "'seme','numero','nero o roso';...
      e risponde con il numero di carte che vuole cambiare, e il server rispondera con un altra stringa contenente le nuove carte
      infine si manda la mano al server che la controlla e ritorna v,p,d per vincita perdita o draw;
    }
