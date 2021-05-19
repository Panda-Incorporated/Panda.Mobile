import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/DistanceDuration.dart';

class Goal extends DistanceDuration {
  bool finished;
  String title;
  double distance; // hoeveel heeft de sporter afgelegd met de nulmeting
  // double doneMaxDistance;
  // Duration doneMaxDuration;
  Duration duration; // hoelang duurde de nulmeting

  DateTime beginday; // begin dag van de eerste nulmeting
  DateTime endday; // dag doel moet voltooid zijn
  //tijdelijk
  int goal; // doel
  List<Activity>
      doneActivity; // lijst met activiteiten die sporter heeft toegevoegd aan doel
  getString() {
    // method van reidert
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

  double getNextPoint() {
    this.doneActivity.sort((a, b) => a.date.compareTo(b.date));
    Activity lastactivity = this.doneActivity.last;
    int kmslastpoint = lastactivity.getSecondsPerKilometer().toInt();
    Activity secondlastactivity =
        this.doneActivity[this.doneActivity.length - 2];

    int kmsfirstpoint = secondlastactivity.getSecondsPerKilometer();

    double diffrencekms = (kmsfirstpoint - kmslastpoint).toDouble();

    double diffrencedays =
        lastactivity.date.difference(secondlastactivity.date).inDays.toDouble();
    double progressionperquantum = diffrencekms / diffrencedays;
    double kmsPredicted = kmslastpoint - progressionperquantum * diffrencedays;
    return kmsPredicted > this.goal ? kmsPredicted : this.goal.toDouble();
  }

  int getMesurement() => // nulmeting (TODO: aanpassen naar eerste activiteit)

      doneActivity.first.getSecondsPerKilometer();
}
