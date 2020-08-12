import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TimerApp());

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(milliseconds: 10);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  List<String> _lapTimes = [];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'stopwatch',
        theme: ThemeData(
          canvasColor: Colors.black12,
          accentColor: Colors.pinkAccent,
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          backgroundColor: Colors.teal[40],
          appBar: AppBar(
            //backgroundColor: Colors.teal[400],
            title: Center(
              child: Text('스톱워치'),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LabelText(
                        label: 'MIN', value: hours.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'SEC',
                        value: minutes.toString().padLeft(2, '0')),
                    LabelText(
                        label: ' ', value: seconds.toString().padLeft(2, '0')),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 90,
                  height: 140,
                  child: ListView(
                    children: _lapTimes
                        .map((time) => Text(
                              time,
                              style: TextStyle(fontSize: 18.0),
                            ))
                        .toList(),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        color: Colors.pink[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: _reset,
                        child: Container(
                          width: 120,
                          height: 37,
                          margin: EdgeInsets.only(top: 20),
                          child: Text('RESET', textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: RaisedButton(
                          color: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              _recordLapTime('$minutes.$hours');
                            });
                          },
                          child: Container(
                            width: 120,
                            height: 37,
                            margin: EdgeInsets.only(top: 20),
                            child: Text('LAPTIME', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  height: 57,
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    color: Colors.pink[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(isActive ? 'STOP' : 'START'),
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

    void _reset() {
    setState(() {
      isActive = false;
      timer?.cancel();
      _lapTimes.clear();
      secondsPassed = 0;
    });
  }

  void _recordLapTime(String time) =>
      _lapTimes.insert(0, '${_lapTimes.length + 1}등 $time');
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.pinkAccent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
