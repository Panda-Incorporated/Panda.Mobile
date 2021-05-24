import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/DistanceDuration.dart';
import 'package:panda/Providers/DBProvider.dart';

//WARNING DB file: if changed, toMap also needs to be changed and DB rebuild.
class Goal extends DistanceDuration {
  int id;
  bool get finished =>
      currentAmountOfStars == totalAmountOfStars &&
      totalAmountOfStars != 0 &&
      totalAmountOfStars != null;
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
  getString() {
    return getCombination(distance.toInt(), duration.inMinutes);
  }

  Future<double> getPercentage() async {
    var _activities = await activities();
    if (_activities == null || _activities.length < 1) return 0;
    print("activities zijn $_activities");
    var nulmeting = _activities.first.RichelFormula(distance);
    var nu_punt = _activities.last.RichelFormula(distance);

    var verschil = nulmeting - goal;
    var progressie = nulmeting - nu_punt;

    var percentage = progressie / verschil;
    return percentage;
  }

  Future<double> getNextPoint() async {
    var _activities = await activities();
    if (_activities != null) {
      _activities.sort((a, b) => a.date.compareTo(b.date));
      Activity lastactivity = _activities.last;
      int kmslastpoint = lastactivity.RichelFormula(this.distance).toInt();
      Activity secondlastactivity = _activities[_activities.length - 2];

      int kmsfirstpoint =
          secondlastactivity.RichelFormula(this.distance).toInt();

      double diffrencekms = (kmsfirstpoint - kmslastpoint).toDouble();

      double diffrencedays = lastactivity.date
          .difference(secondlastactivity.date)
          .inDays
          .toDouble();
      double progressionperquantum = diffrencekms / diffrencedays;
      double kmsPredicted =
          kmslastpoint - progressionperquantum * diffrencedays;

      return kmsPredicted > this.goal ? kmsPredicted : this.goal.toDouble();
    } else
      return -1.0;
  }

  Future<int> getMeasurement() async {
    var _activities = await activities();
    if (_activities != null && _activities.length > 0)
      return _activities.first.RichelFormula(this.distance).toInt();
    else
      return 0;
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
}
