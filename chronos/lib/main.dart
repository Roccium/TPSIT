import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // StreamController per gestire il timer
  final ticker = StreamController<int>.broadcast();
  Timer? tick; //creaiamo il tick da 1 secondo
  bool running = false;
  final orologio = StreamController<int>.broadcast();
  StreamSubscription? pipe;
  bool paused = false;
  int millisecondi = 0;
  bool cliccabile = false;
  var button1 = [
    "start",
    "stop",
    "reset",
  ];
  var button2 = [
    "pause",
    "resume",
  ];
  var state1 = 0;
  var state2 = 0;
  @override
  void initState() {
    super.initState();
    pipe = ticker.stream.listen((value) {
      if (!paused) {
        orologio.add(value); // Passa il dato solo se non in pausa
      }
    });
    ticker.add(0);
  }

  //START
  void startticker() {
    if (!running) {
      setState(() {
        running = true;
      });
      tick = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        millisecondi++;
        ticker.sink.add(millisecondi);
      });
    }
  }

  //STOP
  void stopticker() {
    if (running) {
      tick?.cancel();
      setState(() {
        running = false;
      });
    }
  }

  //RESET
  void resetticker() {
    if (running = true) {
      stopticker();
    }
    if (paused) {
      setState(() {
        paused = false;
        state2 = 0;
      });
    }
    setState(() {
      millisecondi = 0;
    });
    ticker.sink.add(0);

    if (!paused) {
      orologio.sink.add(0);
    }
  }

  //PAUSE
  void pauseorologio() {
    if (!paused) {
      setState(() {
        paused = true;
      });
      stopticker();
    }
  }

  //RESUME
  void resumeorologio() {
    if (state1 == 1) {
      if (paused) {
        setState(() {
          paused = false;
        });
        startticker();
      }
    } else {
      setState(() {
        state2 = 1;
      });
    }
  }

  //check
  void check(int c) {
    switch (c) {
      case 1:
        startticker();
        setState(() {
          cliccabile = true;
        });
        break;
      case 2:
        stopticker();
        break;
      case 3:
        setState(() {
          cliccabile = false;
        });
        resetticker();
        break;
      case 4:
        pauseorologio();
        break;
      case 5:
        resumeorologio();
        break;

      default:
    }
  }

  //PULISCI
  @override
  void dispose() {
    tick?.cancel();
    pipe?.cancel();
    ticker.close();
    orologio.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "STOPWATCH",
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], border: Border.all(), shape: BoxShape.circle),
                child: Center(
                    child: StreamBuilder(
                        stream: orologio.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final int time = snapshot.data ?? 0;
                            final int minuti = time ~/ 600;
                            final int secondi = (time ~/ 10) % 60;
                            final int milli = time % 10;
                            return Text(
                              '${minuti.toString().padLeft(2, '0')}:${secondi.toString().padLeft(2, '0')}:${milli.toString()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 65,
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          } else {
                            return const Text('0');
                          }
                        }))),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(
                          bottom: 100.0,
                          top: 0,
                          right: 15,
                          left: 15,
                        ),
                        child: RepaintBoundary(
                          child: ElevatedButton(
                              onPressed: () => setState(() {
                                    check(state1 + 1);
                                    state1 = (state1 + 1) % button1.length;
                                  }),
                              style: FilledButton.styleFrom(
                                  animationDuration: Duration.zero,
                                  backgroundColor: Colors.amber,
                                  overlayColor: (Colors.transparent),
                                  fixedSize: const Size(150, 100)),
                              child: Text(
                                button1[state1],
                                style: TextStyle(fontSize: 20),
                              )),
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                          bottom: 100.0,
                          top: 0,
                          right: 15,
                          left: 15,
                        ),
                        child: RepaintBoundary(
                          child: ElevatedButton(
                              onPressed: cliccabile
                                  ? () => setState(() {
                                        check(state2 + 4);
                                        state2 = (state2 + 1) % button2.length;
                                      })
                                  : null,
                              style: FilledButton.styleFrom(
                                  animationDuration: Duration.zero,
                                  backgroundColor: Colors.amber,
                                  overlayColor: (Colors.transparent),
                                  fixedSize: const Size(150, 100)),
                              child: Text(
                                button2[state2],
                                style: TextStyle(fontSize: 20),
                              )),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
