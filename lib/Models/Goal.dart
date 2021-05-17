import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/DistanceDuration.dart';

class Goal extends DistanceDuration {
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

  int getMesurement() => // nulmeting (TODO: aanpassen naar eerste activiteit)

      doneActivity.first.getSecondsPerKilometer();
// (duration.inSeconds / distance * 1000).toInt();
}
