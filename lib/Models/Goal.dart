import 'package:panda/Models/DistanceDuration.dart';
import 'package:panda/Models/Planning.dart';

class Goal extends DistanceDuration {
  bool finished;
  String title;
  double distance;
  double doneMaxDistance;
  Duration doneMaxDuration;
  Duration duration;
  List<Planning> listPlanning;
  getString(){
    return getCombination(distance.toInt(),duration.inMinutes);
  }
}
