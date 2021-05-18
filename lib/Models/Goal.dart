import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/DistanceDuration.dart';

//WARNING DB file: if changed, toMap also needs to be changed and DB rebuild.
class Goal extends DistanceDuration {
  int id;

  bool finished;
  String title;
  double distance;
  Duration duration;

  DateTime beginday; // begin dag van de eerste nulmeting
  DateTime endday; // dag doel moet voltooid zijn
  //tijdelijk
  int goal; // doel
  List<Activity>
      doneActivity; // lijst met activiteiten die sporter heeft toegevoegd aan doel
  Goal();
  Goal.fill({this.id, this.duration, this.title, this.distance});
  getString() {
    return getCombination(distance.toInt(), duration.inMinutes);
  }

  double getPercentage() {
    // percentage done moet vervangen worden door nieuwe formule staat in documentatie onedrive

    var nulmeting = doneActivity.first.getSecondsPerKilometer();
    var nu_punt = doneActivity.last.getSecondsPerKilometer();

    var verschil = nulmeting - goal;
    var progressie = nulmeting - nu_punt;

    var percentage = progressie / verschil;
    return percentage;
  }

  int getMesurement() => doneActivity.first.getSecondsPerKilometer();
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'distance': distance,
      'duration': duration.inSeconds,
    };
  }
}
