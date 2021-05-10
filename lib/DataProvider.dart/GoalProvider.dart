import 'package:panda/Models/Goal.dart';
import 'package:panda/Models/Planning.dart';

class GoalProvider {
  static List<Goal> getGoals() {
    return [
      Goal()
        ..finished = false
        ..title = "Marathon"
        ..distance = 25.0
        ..doneMaxDistance = 20.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 20
        ..doneMaxDuration = Duration(minutes: 50)
      // ..listPlanning = [
      //   Planning()
      //     ..distance = 5
      //     ..title = "Morgen"
      //     ..duration = Duration(minutes: 15),
      //   Planning()
      //     ..distance = 10
      //     ..title = "Overmorgen"
      //     ..duration = Duration(minutes: 30)
      // ]
      ,
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 10.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 10
        ..doneMaxDuration = Duration(minutes: 30),
      // ..listPlanning = [],
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 5.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 5
        ..doneMaxDuration = Duration(minutes: 30),
      // ..listPlanning = [],
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 2.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 2
        ..doneMaxDuration = Duration(minutes: 30)
      // ..listPlanning = [],
    ];
  }

  static double getPercentage(Goal goal) {
    return (((goal.doneMaxDistance / goal.distance) * 100) +
            ((goal.duration.inMicroseconds /
                    goal.doneMaxDuration.inMicroseconds) *
                100)) /
        2;
  }
}
