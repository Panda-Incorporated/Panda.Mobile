import 'package:intl/intl.dart';

import 'Goal.dart';

//WARNING DB file: if changed, toMap also needs to be changed and DB rebuild.
class Activity {
  int id;
  int goalId;
  Goal goal;
  DateTime date; // datum activiteit
  double distance; // meters afgelegd activiteit
  Duration duration; // tijd activiteit
  Activity();
  Activity.fill(
      {this.id,
      this.goalId,
      this.duration,
      this.distance,
      this.goal,
      this.date});
  String dayFormat() => DateFormat('dd-MM-yyyy').format(this.date);

  String timeFormat() =>
      this.duration.toString().split('.').first.padLeft(8, "0");

  int getSecondsPerKilometer() {
    // seconds/km van activiteit
    return (duration.inSeconds / distance * 1000).toInt();
  }

  int getDaysFromStartDay(DateTime startday) {
    // hoeveel dagen van start punt (gebruikt om x as van grafiek te tekenen)
    // present-future
    return this.date.difference(startday).inDays;
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'distance': distance,
      'duration': duration.inSeconds,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map, {DateTime dateTime}) {
    return Activity.fill(
      date: dateTime != null ? dateTime : DateTime.parse(map['date']),
      distance: map['distance'],
      duration: Duration(milliseconds: map['duration']),
    );
  }
}
