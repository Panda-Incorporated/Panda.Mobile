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
      this.currentAmountOfStars});

  Future<String> getLastactivity() async {
    var act = await activities();
    if (act != null && act.length > 0) {
      act.sort((a, b) => a.date.compareTo(b.date));
      var minimalday = act.last.date.add(Duration(days: 2));
      minimalday =
          minimalday.isBefore(DateTime.now()) ? minimalday : DateTime.now();
      minimalday = minimalday.isBefore(endday.subtract(Duration(days: 2)))
          ? minimalday
          : endday.subtract(Duration(days: 2));
      return DateFormat("dd-MM").format(minimalday);
    }
    return "";
  }

  Future<double> getPercentage() async {
    var _activities = await activities();
    if (_activities == null || _activities.length < 1) return 0;

    var nulmeting = _activities.first.RichelFormula(distance);
    var nu_punt = pow(_activities.last.RichelFormula(distance), 0.95) - 2;
    var verschil = nulmeting - goal;
    var progressie = nulmeting - nu_punt;
    var percentage = progressie / verschil;
    var perc = (percentage * 100).toInt();
    if (currentAmountOfStars != perc) {
      currentAmountOfStars = perc;

      var db = await DBProvider.helper.getDatabase();
      await db.update("Goal", {"currentAmountOfStars": currentAmountOfStars},
          where: "id = ?", whereArgs: [id]);
    }
    return percentage >= 1.0
        ? 1.0
        : percentage < 0.0
            ? 0.0
            : percentage;
  }

  int getTotalDays() {
    return endday.difference(beginday).inDays + 1;
  }

  Future<double> getNextPoint() async {
    var _activities = await activities();
    if (_activities == null || _activities.length < 2) return -1.0;
    _activities.sort((a, b) => a.date.compareTo(b.date));
    Activity lastactivity = _activities.last;
    int kmslastpoint = lastactivity.RichelFormula(distance).toInt();
    Activity secondlastactivity = _activities[_activities.length - 2];

    int kmsfirstpoint = secondlastactivity.RichelFormula(distance).toInt();

    double diffrencekms = (kmsfirstpoint - kmslastpoint).toDouble();

    double diffrencedays = lastactivity.date
            .difference(secondlastactivity.date)
            .inDays
            .toDouble() +
        1;
    double progressionperquantum = diffrencekms / diffrencedays;
    double kmsPredicted = kmslastpoint - progressionperquantum * diffrencedays;

    return kmsPredicted > this.goal ? kmsPredicted : this.goal.toDouble();
  }

  Future<int> getMeasurement() async {
    var _activities = await activities();
    if (_activities != null && _activities.length > 0)
      return _activities.first.RichelFormula(distance).toInt();
    else
      return 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'distance': distance,
      'duration': duration.inSeconds,
      'currentAmountOfStars': currentAmountOfStars,
      'endday': DateFormat("yyyy-MM-dd hh:mm:ss").format(endday),
      'beginday': DateFormat("yyyy-MM-dd hh:mm:ss").format(beginday),
    };
  }

  Future<int> getMetersToRun() async {
    var mes = await getMeasurement();
    var _activities = await activities();
    if (_activities == null || _activities.length <= 0) return 0;
    var lastact = _activities.last;
    double y = (goal - (mes * 60)) /
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
    var minimal = (distance * 0.05);
    var current = (y / duration.inMinutes);
    y = current < minimal ? minimal : current;
    return y.toInt();
  }
}
