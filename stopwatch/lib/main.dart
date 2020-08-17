import 'dart:async';
import 'package:flutter/material.dart';
import 'StopWatchManager.dart';
import 'TimerView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StopWatchManager manager = new StopWatchManager();
  Icon leftButtonIcon;
  Icon rightButtonIcon;

  Color leftButtonColor;
  Color rightButtonColor;

  Timer timer;

  updateTime(Timer timer) {
    if (manager.stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    if (manager.stopwatch.isRunning) {
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.fiber_manual_record,
        color: Colors.red,
      );
      rightButtonColor = Colors.white70;
    } else {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STOPWATCH"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              height: 250.0,
              //width: 250.0,
              child: TimerView(manager),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                    backgroundColor: leftButtonColor,
                    onPressed: startOrStopWatch,
                    child: leftButtonIcon),
                SizedBox(width: 20.0),
                FloatingActionButton(
                    backgroundColor: rightButtonColor,
                    onPressed: saveOrRefreshWatch,
                    child: rightButtonIcon),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              //width: 90,
              height: 140,
              child: ListView(
                children: manager.savedTimeList
                    .map((time) => Text(
                          time,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0),
                        ))
                    .toList(),
              ),
            ),
            //Text('$savedTimeList')
          ],
        ),
      ),
    );
  }

  startOrStopWatch() {
    if (manager.stopwatch.isRunning) {
      leftButtonIcon = Icon(Icons.play_arrow);
      leftButtonColor = Colors.green;
      rightButtonIcon = Icon(Icons.refresh);
      rightButtonColor = Colors.blue;
      manager.stopwatch.stop();
      setState(() {});
    } else {
      leftButtonIcon = Icon(Icons.pause);
      leftButtonColor = Colors.red;
      rightButtonIcon = Icon(
        Icons.fiber_manual_record,
        color: Colors.red,
      );
      rightButtonColor = Colors.white70;
      manager.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 20), updateTime);
    }
  }

  saveOrRefreshWatch() {
    setState(() {
      if (manager.stopwatch.isRunning) {
        manager.savedTimeList.insert(
            0,
            manager.convertMilliSecondsToString(
                manager.stopwatch.elapsedMilliseconds));
      } else {
        manager.stopwatch.reset();
        manager.savedTimeList.clear();
      }
    });
  }
}
