import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  _StopWatchScreenState createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  String elapsedTime = '00:00.00';
  Timer timer;
  final Stopwatch watch = Stopwatch();
  bool watchStatus = false;

  List<String> labItems = [];

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        padding: EdgeInsets.all(10),
        width: 300,
        height: 300,
        color: Colors.yellow.shade700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              elapsedTime,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.alarm_add),
                  onPressed: () {
                    if (!watchStatus) {
                      startWatch();
                    } else {
                      watchStatus = false;
                      stopWatch();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.save_alt),
                  onPressed: () {
                    setState(() {
                      labItems.add(elapsedTime);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.repeat),
                  onPressed: () {
                    setState(() {
                      resetWatcher();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: labItems.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return new Container(
                    alignment: Alignment.center,
                    child: Text(
                      labItems[Index],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }

  void updateElapsedTime(Timer timer) {
    setState(() {
      elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
    });
  }

  void startWatch() {
    watch.start();
    watchStatus = true;
    timer =
        new Timer.periodic(new Duration(milliseconds: 100), updateElapsedTime);
  }

  void stopWatch() {
    watch.stop();
    watchStatus = false;
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr.$hundredsStr";
  }

  void resetWatcher() {
    if (!watchStatus) {
      setState(() {
        elapsedTime = '00:00.00';
        labItems = [];
      });
    }
  }
}
