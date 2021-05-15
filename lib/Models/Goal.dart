import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/DistanceDuration.dart';

class Goal extends DistanceDuration {
  bool finished;
  String title;
  double distance; // hoeveel heeft de sporter afgelegd met de nulmeting
  double doneMaxDistance;
  Duration doneMaxDuration;
  Duration duration; // hoelang duurde de nulmeting

  DateTime beginday; // begin dag van de eerste nulmeting
  DateTime endday; // dag doel moet voltooid zijn
  //tijdelijk
  int secondsperkilometer; // doel
  List<Activity>
      doneActivity; // lijst met activiteiten die sporter heeft toegevoegd aan doel
  getString() {
    // method van reidert
    return getCombination(distance.toInt(), duration.inMinutes);
  }

  int getPercentage() {
    // percentage done moet vervangen worden door nieuwe formule staat in documentatie onedrive
    return (((this.doneMaxDistance / this.distance) * 100) +
            ((this.duration.inMicroseconds /
                    this.doneMaxDuration.inMicroseconds) *
                100)) ~/
        2;
  }

  int getSecondsPerKilometer() => // krijg seconds/km van de nulmeting
      (duration.inSeconds / distance * 1000).toInt();
}
