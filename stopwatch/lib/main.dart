import 'package:flutter/material.dart';
import 'package:stopwatch/stop_watch_screen.dart';

void main() {
  runApp(StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  final String title = 'StopWatch';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: StopWatchScreen(
          title: title,
        ),
      ),
    );
  }
}
