import 'package:intl/intl.dart';

class Activity {
  DateTime date; // datum activiteit
  int meters; // meters afgelegd activiteit
  Duration totalactivitytime; // tijd activiteit

  // laten staan is misschien nog handig
  // Activity(
  //   {@required this.date, @required this.meters, @required this.seconds});

  String dayFormat() => DateFormat('dd-MM-yyyy').format(this.date);

  String timeFormat() =>
      this.totalactivitytime.toString().split('.').first.padLeft(8, "0");

  int getSecondsPerKilometer() {
    // seconds/km van activiteit
    return (totalactivitytime.inSeconds / meters * 1000).toInt();
  }

  int getDaysFromStartDay(DateTime startday) {
    // hoeveel dagen van start punt (gebruikt om x as van grafiek te tekenen)
    // present-future
    return this.date.difference(startday).inDays;
  }
}
