import 'package:panda/Models/DistanceDuration.dart';

class Planning extends DistanceDuration {
  String title;
  double distance;
  Duration duration;
  getString() {
    return getCombination(distance.toInt(), duration.inMinutes);
  }
}
