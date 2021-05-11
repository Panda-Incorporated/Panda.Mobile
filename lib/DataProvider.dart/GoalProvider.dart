import 'package:panda/Models/Goal.dart';

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
        ..doneMaxDuration = Duration(minutes: 50),
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 10.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 10
        ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 5.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 5
        ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..finished = false
        ..title = "Marathon"
        ..distance = 2.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 1.7
        ..doneMaxDuration = Duration(minutes: 30)
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
