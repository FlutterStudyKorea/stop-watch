import 'CurrentTime.dart';


class StopWatchManager {
  final Stopwatch stopwatch = new Stopwatch();

  final List<String> savedTimeList = List<String>();

  convertMilliSecondsToString(int ms) {
    int milliseconds = (ms / 10).truncate();
    int seconds = (milliseconds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String hundredsStr = (milliseconds % 100).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');


    return '$minutesStr : $secondsStr.$hundredsStr';
  }

  convertMilliSecondsToTime(int ms) {
    int milliseconds = (ms / 10).truncate();
    int seconds = (milliseconds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    return CurrentTime(
        milliseconds: milliseconds % 100,
        seconds: seconds % 60,
        minutes: minutes % 60);
  }
}