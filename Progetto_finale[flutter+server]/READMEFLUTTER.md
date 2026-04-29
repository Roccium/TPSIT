# Consegna Finale: Armadio Digitale
**Sviluppatore:** [Il Tuo Nome]  
**Corso:** [Nome del Corso/Materia]  
**Data di Consegna:** [Inserisci Data]

---

## Abstract
Il progetto consiste in un'applicazione mobile sviluppata in **Flutter** che permette agli utenti di digitalizzare il proprio guardaroba. L'app offre funzionalità di autenticazione (multi-utenza), acquisizione di foto tramite fotocamera, rimozione automatica dello sfondo tramite un servizio API dedicato e organizzazione dei capi in categorie personalizzabili. L'obiettivo è fornire uno strumento intuitivo per visualizzare e comporre outfit partendo da una base dati locale persistente.

---

## Scelte Progettuali e Motivazioni

### 1. Architettura State Management (Provider)
È stato scelto il package **Provider** per la gestione dello stato globale (file `notiefier.dart`). Questa scelta è motivata dalla necessità di mantenere sincronizzata l'interfaccia utente (Home, Pop-up, Galleria) con i dati del database in modo reattivo, garantendo al contempo una netta separazione tra logica di business e UI.

### 2. Persistenza Dati e Multi-utenza Locale
Per la gestione dei dati è stato utilizzato **SQLite** tramite il plugin `sqflite`.
- **Scelta:** Ogni utente loggato dispone di un file di database fisico dedicato (es. `armadio_nomeutente.db`).
- **Motivazione:** Questa architettura garantisce la massima privacy locale e semplicità nella gestione dei dati: eliminando un utente, si elimina semplicemente il suo file dedicato senza dover gestire complesse query di filtraggio su un unico database massivo.

### 3. Pattern Singleton e Factory
Nel file `database_helper.dart` è stato implementato il pattern **Singleton** combinato con un **Factory Constructor**.
- **Motivazione:** Questo previene l'apertura multipla di connessioni allo stesso file di database, che causerebbe crash o corruzione dei dati. La factory gestisce dinamicamente la "mappa" delle istanze in base all'utente loggato.

### 4. Elaborazione Immagini (Rimozione Sfondo)
L'app integra una chiamata HTTP (file `http_helper.dart`) a un backend PHP che funge da bridge verso servizi di computer vision.
- **Motivazione:** L'elaborazione neurale per la rimozione dello sfondo è troppo onerosa per essere eseguita in locale su dispositivi di fascia media; delegare il compito a un server permette di mantenere l'app fluida e leggera.

---

## Diario di Progetto (Step di Avanzamento)

*Questa sezione documenta l'evoluzione del software in corrispondenza dei commit principali.*

- **Step 1:** [Data] - Configurazione ambiente, definizione dei modelli dati (`Capo`, `SezioneArmadio`) e costanti grafiche.
- **Step 2:** [Data] - Implementazione del sistema di autenticazione e collegamento con `HttpHelper`.
- **Step 3:** [Data] - Sviluppo della logica di persistenza locale con `DatabaseHelper` e supporto multi-utente.
- **Step 4:** [Data] - Integrazione modulo `Camera.dart` e gestione del caricamento immagini con rimozione dello sfondo.
- **Step 5:** [Data] - Creazione dell'interfaccia di visualizzazione dinamica (`HomeView`, `BodyZone`) e gestione del drag & drop.
- **Step 6:** [Data] - Rifinitura UI, gestione dei profili e ottimizzazione della Null Safety.

---

## Pulizia del Codice
Il codice segue le linee guida ufficiali di Dart ("Effective Dart"):
- Utilizzo di **Null Safety** per prevenire errori a runtime.
- Suddivisione del progetto in cartelle logiche: `Widgets`, `Helpers`, `Models`.
- Utilizzo di costanti centralizzate (`costanti.dart`) per mantenere coerenza cromatica e stilistica.

---

## Fonti Utilizzate
1. **Documentazione Ufficiale Flutter:** [flutter.dev/docs](https://flutter.dev/docs)
2. **Sqflite Guide:** Gestione dei database locali in SQLite.
3. **Provider Pattern:** Best practices per lo State Management.
4. **Camera Plugin:** Documentazione per l'acquisizione di flussi video e scatto foto.
5. **StackOverflow/Dart Pad:** Risoluzione di problematiche specifiche su Factory Constructors e Null Assertion.