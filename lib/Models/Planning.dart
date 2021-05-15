import 'package:panda/Models/DistanceDuration.dart';

//TODO: verwijderen
class Planning extends DistanceDuration {
  String title;
  double distance;
  Duration duration;
  getString() {
    return getCombination(distance.toInt(), duration.inMinutes);
  }
}
