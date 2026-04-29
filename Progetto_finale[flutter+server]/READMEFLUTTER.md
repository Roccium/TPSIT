# Consegna Finale: Armadio Digitale
**Rocco**     
**Progetto finale TPSIT** 

---

## Consegna finale
Il progetto è un applicazione mobile(progettata per android) in **Flutter** che crea un 'armadio virtuale' dove le persone possono provare combinazione dei loro vestiti per trovare nuove possibili abbinazioni.
L'app offre la multi-utenza, scatto di foto tramite CameraX, rimozione dello sfondo con una chiamata API a un servizio e l'organizzazione dei capi in categorie specializzate.
L'obiettivo è fornire uno strumento intuitivo per visualizzare e comporre outfit partendo da una base dati locale persistente.
---
## Scelte e Motivazioni

### 1. (Notiefier)
È stato scelto il un **Notiefier** personalizzato per avere un controllo estremo e personallizato dell applicativo per coprire tutti i vari casi limite senza sprecare troppo tempo a cercare il notiefier perfetto per il mio caso d'utenza.
```
  List<Map<String, dynamic>> get widgets => _widgets;
  List<SezioneArmadio> get sezioni => _sezioni;
  bool get isLoading => _isLoading;
```
### 2. Persistenza Dati e Multi-utenza
Per la gestione dei dati è stato utilizzato **SQLite** tramite il plugin `sqflite`.
- **Scelta:** Ogni utente loggato dispone di un file di database fisico dedicato (es. `armadio_nomeutente.db`).
- **Motivazione:** Questa scleta garantisce la privacy locale e semplicità nella gestione dei dati: eliminando un utente, l'ho usato per una motivazione di tempistiche e di complessita per la deadline alle porte

### 3. Pattern Singleton e Factory
Nel file `database_helper.dart` è stato implementato il pattern **Singleton** combinato con un **Factory Constructor**.
- **Motivazione:** Questo previene l'apertura multipla di connessioni allo stesso file di database, che causerebbe crash o corruzione dei dati. La factory gestisce dinamicamente la istanze in base all'utente loggato.
```
  static final Map<String, DatabaseHelper> _stanze = {};

  final String nomeUtente;
  Database? _database;

  // Il factory constructor ora cerca nella mappa prima di creare
  factory DatabaseHelper(String nomeUtente) {
    if (_stanze.containsKey(nomeUtente)) {
      return _stanze[nomeUtente]!;
    } else {
      final nuovaIstanza = DatabaseHelper._internal(nomeUtente);
      _stanze[nomeUtente] = nuovaIstanza;
      return nuovaIstanza;
    }
  }
```
### 4. Elaborazione Immagini (Rimozione Sfondo)
L'app integra una chiamata HTTP (file `http_helper.dart`) a un backend PHP che funge da ponte verso servizi di computer vision.
- **Motivazione:** decentralizzazione del lavoro svolto e per evitare di esporre le API key nell applicativo

---

## Diario di Progetto (Step di Avanzamento)

*Questa sezione documenta l'evoluzione del software in corrispondenza dei commit principali.*

-  [29/4/2026] - Tocchi finali e connessione finale tra server e applicativo, controllo che funzioni la rimozione degli sfondi
-  [28/4/2026] - Connesso il server e l'applicativo per quanto riguarda gli accessi e le password quasi finito il server
-  [27/4/2026] - Fatto la logica interna e draggableWidget per ingrandire, spostare e modificare i capi
-  [23/4/2026] - Cambiato completamente rotta del progetto deciso che la strada dei pacchetti non ne valeva la pena, faccio tutto in locale
-  [21/4/2026] -Finito la home
-  [16/4/2026] - Migliorie UI e finito la fotocamera
-  [15/4/2027] - UI
-  [12/4/2026] - Iniziato a sviluppare la fotocamera con CameraX, iniziato a lavorare al server, iniaziato a fare la homeview, iniziato a fare il notiefier, iniziato a fare il databasehelper
---

## Pulizia del Codice
- Suddivisione del progetto in cartelle : `Widgets`, `Helpers`, `Models`.
- Utilizzo di costanti centralizzate (`costanti.dart`) per mantenere la scelta stilistica.

---

## Fonti Utilizzate
1. **Documentazione Ufficiale Flutter:** [flutter.dev/docs](https://flutter.dev/docs)
2. **Sqflite Guide:** Gestione dei database locali in SQLite.
3. **Reddit** Risoluzione a problemi comuni tra gli sviluppatori.
4. **Camera Plugin:** Documentazione per l'acquisizione di flussi video e scatto foto.
5. **StackOverflow/Dart Pad:** Risoluzione di problematiche specifiche su Factory Constructors e Null Assertion.
6. **API** https://www.remove.bg/api#sample-code