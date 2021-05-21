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
  int get goal =>
      duration != null ? duration.inSeconds ~/ (distance ~/ 1000) : 0; // doel
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
    // percentage done moet vervangen worden door nieuwe formule staat in documentatie onedrive
    var _activities = await activities();
    var nulmeting = _activities.first.getSecondsPerKilometer();
    var nu_punt = _activities.last.getSecondsPerKilometer();

    var verschil = nulmeting - goal;
    var progressie = nulmeting - nu_punt;

    var percentage = progressie / verschil;
    return percentage;
  }

  Future<double> getNextPoint() async {
    var _activities = await activities();
    _activities.sort((a, b) => a.date.compareTo(b.date));
    Activity lastactivity = _activities.last;
    int kmslastpoint = lastactivity.getSecondsPerKilometer().toInt();
    Activity secondlastactivity = _activities[_activities.length - 2];

    int kmsfirstpoint = secondlastactivity.getSecondsPerKilometer();

    double diffrencekms = (kmsfirstpoint - kmslastpoint).toDouble();

    double diffrencedays =
        lastactivity.date.difference(secondlastactivity.date).inDays.toDouble();
    double progressionperquantum = diffrencekms / diffrencedays;
    double kmsPredicted = kmslastpoint - progressionperquantum * diffrencedays;
    return kmsPredicted > this.goal ? kmsPredicted : this.goal.toDouble();
  }

  Future<int> getMeasurement() async {
    var _activities = await activities();
    return _activities.first.getSecondsPerKilometer();
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
