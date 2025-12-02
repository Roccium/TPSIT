import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker/carta.dart';
import 'package:poker/retro_carta.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff067509),
      body: Center(
          child: Container(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                  transform: Matrix4.identity()
                    ..translate(75, -30)
                    ..rotateZ(0.55),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(40, -10)
                    ..rotateZ(0.30),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()..translate(0.0, 0),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-40, 3)
                    ..rotateZ(-0.30),
                  child: RetroCard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-70, -5)
                    ..rotateZ(-0.45),
                  child: RetroCard()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                    top: 0,
                    right: 15,
                    left: 15,
                  ),
                  child: RetroCard()),
              Container(
                child: Mycard(),
              ),
              Container(
                width: 90,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-5, 46)
                    ..rotateZ(-0.45),
                  child: Mycard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(-5, 15)
                    ..rotateZ(-0.25),
                  child: Mycard()),
              Mycard(),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(5, 3)
                    ..rotateZ(0.25),
                  child: Mycard()),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(10, 21)
                    ..rotateZ(0.45),
                  child: Mycard()),
            ],
          )
        ]),
      )),
    );
  }
}
