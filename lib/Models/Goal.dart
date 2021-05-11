import 'package:panda/Models/DistanceDuration.dart';

class Goal extends DistanceDuration {
  bool finished;
  String title;
  double distance;
  double doneMaxDistance;
  Duration doneMaxDuration;
  Duration duration;
  DateTime beginday;
  DateTime endday;
  //tijdelijk
  int secondsperkilometer;
  getString() {
    return getCombination(distance.toInt(), duration.inMinutes);
  }

  double getPercentage() {
    return (((this.doneMaxDistance / this.distance) * 100) +
            ((this.duration.inMicroseconds /
                    this.doneMaxDuration.inMicroseconds) *
                100)) /
        2;
  }

  // 1km in 1 uur
  //60x60 = 360
  // kilometers / seconds
  int getSecondsPerKilometer() {
    return (duration.inSeconds / distance * 1000).toInt();
  }
}
