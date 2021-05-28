import 'dart:math';

import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Providers/DBProvider.dart';

//WARNING DB file: if changed, toMap also needs to be changed and DB rebuild.
class Goal {
  int id;

  bool get finished =>
      currentAmountOfStars != null && currentAmountOfStars >= 100;
  String title;
  double distance;
  Duration duration;
  int currentAmountOfStars = 0;
  int totalAmountOfStars = 0;
  DateTime beginday; // begin dag van de eerste nulmeting
  DateTime endday; // dag doel moet voltooid zijn
  //tijdelijk
  int get goal => (duration != null &&
          duration.inSeconds > 0 &&
          distance > 0 &&
          distance != null)
      ? duration.inSeconds ~/ (distance ~/ 1000)
      : 0; // doel
  Future<List<Activity>> activities() async {
    return await DBProvider.helper
        .getActivities(where: "goalid = ?", whereArgs: [id]);
  } // lijst met activiteiten die sporter heeft toegevoegd aan doel

  Goal();

  Goal.fill(
      {this.id,
      this.duration,
      this.title,
      this.distance,
      this.beginday,
      this.endday,
      this.totalAmountOfStars,
      this.currentAmountOfStars});

  // getString() {
  //   return getCombination(distance.toInt(), duration.inMinutes);
  // }

  int getDaysLeft() {
    return endday.difference(DateTime.now()).inDays;
  }

  int getSecondsPerKilometer() {
    // seconds/km van activiteit
    return (duration.inSeconds / distance * 1000).toInt();
  }

  Future<String> getLastactivity() async {
    var act = await activities();
    if (act != null && act.length > 0) {
      act.sort((a, b) => a.date.compareTo(b.date));
      var minimalday = act.last.date.add(Duration(days: 2));
      minimalday =
          minimalday.isBefore(DateTime.now()) ? DateTime.now() : minimalday;
      return DateFormat("dd-MM").format(minimalday);
    }
  }

  Future<double> getPercentage() async {
    var _activities = await activities();
    if (_activities == null || _activities.length < 1) return 0;
    print("activities zijn $_activities");
    var nulmeting = _activities.first.RichelFormula(distance);
    var nu_punt = _activities.last.RichelFormula(distance);
    // var nulmeting = _activities.first.getSecondsPerKilometer();
    // var nu_punt = _activities.last.getSecondsPerKilometer();
    var verschil = nulmeting - goal;
    var progressie = nulmeting - nu_punt;
    var percentage = progressie / verschil;
    var perc = (percentage * 100).toInt();
    if (currentAmountOfStars != perc) {
      currentAmountOfStars = percentage.toInt();
      totalAmountOfStars = 100;
      var db = await DBProvider.helper.getDatabase();
      await db.update("Goal", {"currentAmountOfStars": currentAmountOfStars},
          where: "id = ?", whereArgs: [id]);
    }

    return percentage;
  }

  int getTotalDays() {
    return endday.difference(beginday).inDays;
  }

  Future<double> getNextPoint() async {
    var _activities = await activities();
    if (_activities == null || _activities.length < 2) return -1.0;
    _activities.sort((a, b) => a.date.compareTo(b.date));
    Activity lastactivity = _activities.last;
    int kmslastpoint = lastactivity.RichelFormula(this.distance).toInt();
    Activity secondlastactivity = _activities[_activities.length - 2];

    int kmsfirstpoint = secondlastactivity.RichelFormula(this.distance).toInt();

    double diffrencekms = (kmsfirstpoint - kmslastpoint).toDouble();

    double diffrencedays =
        lastactivity.date.difference(secondlastactivity.date).inDays.toDouble();
    double progressionperquantum = diffrencekms / diffrencedays;
    double kmsPredicted = kmslastpoint - progressionperquantum * diffrencedays;

    return kmsPredicted > this.goal ? kmsPredicted : this.goal.toDouble();
  }

  Future<int> getMeasurement() async {
    var _activities = await activities();
    if (_activities != null && _activities.length > 0)
      return _activities.first.RichelFormula(this.distance).toInt();
    else
      return 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'distance': distance,
      'duration': duration.inSeconds,
      'currentAmountOfStars': currentAmountOfStars,
      'totalAmountOfStars': totalAmountOfStars,
      'endday': DateFormat("yyyy-MM-dd hh:mm:ss").format(endday),
      'beginday': DateFormat("yyyy-MM-dd hh:mm:ss").format(beginday),
    };
  }

  Future<Duration> getMinutesToRun() async {
    int initalTime = duration.inSeconds;
    var mes = await getMeasurement();
    var _duration = Duration();
    int amountofParts = mes - goal;
    int goal1 = mes;
    int goal2 = mes - (amountofParts * 0.25).toInt();
    int goal3 = mes - (amountofParts * 0.5).toInt();
    int goal4 = mes - (amountofParts * 0.75).toInt();
    var _activities = await activities();
    var lastact = _activities.last;
    if (lastact.RichelFormula(distance) < goal1)
      _duration = Duration(seconds: initalTime ~/ 4);
    if (lastact.RichelFormula(distance) < goal2)
      _duration = Duration(seconds: initalTime ~/ 3);
    if (lastact.RichelFormula(distance) < goal3)
      _duration = Duration(seconds: initalTime ~/ 2);
    if (lastact.RichelFormula(distance) < goal4)
      _duration = Duration(seconds: initalTime ~/ 1);
    if (_duration.inMinutes < 2) Duration(minutes: 2);
    if (getDaysLeft() < 2) return Duration(minutes: 0);
    return _duration;
  }

  Future<int> getMetersToRun() async {
    var mes = await getMeasurement();
    var _activities = await activities();
    if (_activities == null || _activities.length <= 0) return 0;
    var lastact = _activities.last;
    var y = (goal - (mes * 60)) /
            sqrt(getTotalDays()) *
            sqrt(
                endday.difference(lastact.date.add(Duration(days: 2))).inDays) +
        (mes * 60);

    if (duration.inMinutes.isNaN ||
        duration.inMinutes.isInfinite ||
        y.isNaN ||
        y.isInfinite) {
      return 0;
    }
    return y ~/ duration.inMinutes;
  }
}
