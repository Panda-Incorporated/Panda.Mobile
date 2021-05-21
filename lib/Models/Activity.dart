import 'dart:math';

import 'package:intl/intl.dart';

import 'Goal.dart';

//WARNING DB file: if changed, toMap also needs to be changed and DB rebuild.
class Activity {
  int id;
  int goalId;
  Goal goal;
  String name;
  DateTime date; // datum activiteit
  double distance; // meters afgelegd activiteit
  Duration duration; // tijd activiteit
  Activity();

  Activity.fill({this.id,
    this.goalId,
    this.duration,
    this.distance,
    this.goal,
    this.name,
    this.date});

  String dayFormat() =>
      date != null ? DateFormat('dd-MM-yyyy').format(this.date) : "Geen datum";

  String timeFormat() =>
      this.duration.toString().split('.').first.padLeft(8, "0");

  int getSecondsPerKilometer() {
    // seconds/km van activiteit
    return (duration.inSeconds / distance * 1000).toInt();
  }

  double RichelFormula(goaldistance) {
    //return ;
    return pow(
        this.getSecondsPerKilometer() * (goaldistance / this.distance), 1.06);
  }

  int getDaysFromStartDay(DateTime startday) {
    // hoeveel dagen van start punt (gebruikt om x as van grafiek te tekenen)
    // present-future
    return this.date.difference(startday).inDays;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': DateFormat().format(date),
      'distance': distance,
      'duration': duration.inSeconds,
      'name': name,
      'goalId': goalId,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map, {DateTime dateTime}) {
    return Activity.fill(
      name: map['name'],
      date: dateTime != null ? dateTime : DateFormat().parse(map['date']),
      distance: map['distance'],
      duration: Duration(milliseconds: map['duration']),
    );
  }
}
