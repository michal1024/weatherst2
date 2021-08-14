import 'dart:async';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  @override
  State createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _time = DateTime.now();

  void _updateTime(Timer t) {
    setState(() => _time = DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext ctx) {
    return Center(child: ClockFace(time: _time));
  }
}

class ClockFace extends StatelessWidget {
  final DateTime time;

  ClockFace({required this.time});

  @override
  Widget build(BuildContext ctx) {
    return Row(children: [
      Digit(value: time.hour),
      Separator(show: time.second % 2 != 0),
      Digit(value: time.minute)
    ],
    mainAxisAlignment: MainAxisAlignment.center,);
  }
}

final style = TextStyle(fontSize: 64);

class Digit extends StatelessWidget {
  final int value;
  Digit({required this.value});

  @override
  Widget build(BuildContext ctx) {
    return Text(value.toString().padLeft(2, '0'), style: style);
  }
}

class Separator extends StatelessWidget {
  final bool show;
  Separator({required this.show});

  @override
  Widget build(BuildContext ctx) {
    var content = Text(show ? ':' : '', style: style);
    return SizedBox(child: content, width: 16);
  }  
}