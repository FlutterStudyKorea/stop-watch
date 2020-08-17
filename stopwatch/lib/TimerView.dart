
import 'package:flutter/material.dart';
import 'package:stopwatch/StopWatchManager.dart';
import 'package:stopwatch/CurrentTime.dart';

class TimerView extends StatefulWidget {
  final StopWatchManager manager;
  TimerView(this.manager) ;
  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {


  @override
  Widget build(BuildContext context) {

    CurrentTime currentTime =  widget.manager.convertMilliSecondsToTime(
        widget.manager.stopwatch.elapsedMilliseconds ) ;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 48.0),
            ),
            Text(
             ' ${currentTime.milliseconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 24.0),
            )],
        ),
        ],
      ),
    );
  }
}


