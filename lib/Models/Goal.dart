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
}
