import 'package:panda/Models/DistanceDuration.dart';

class Goal extends DistanceDuration {
  bool finished;
  String title;
  double distance;
  double doneMaxDistance;
  Duration doneMaxDuration;
  Duration duration;
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
}
