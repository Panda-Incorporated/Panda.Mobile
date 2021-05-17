import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';

class GoalProvider {
  static List<Goal> getGoals() {
    //NIET GOAL 1 AANPASSEN IS TEST UNIT
    return [
      Goal()
        ..finished = false
        ..title = "Marathon"
        ..distance = 1000
        ..doneMaxDistance = 1.0
        ..duration = Duration(minutes: 9, seconds: 39)
        ..doneMaxDistance = 1
        //doel
        ..secondsperkilometer = 500
        ..beginday = DateTime(2021, DateTime.may, 11)
        ..endday = DateTime(2021, DateTime.may, 31)
        ..doneMaxDuration = Duration(minutes: 50)
        ..doneActivity = [
          Activity()
            ..meters = 1500
            ..totalactivitytime = Duration(minutes: 13, seconds: 40)
            ..date = DateTime(2021, DateTime.may, 17),
          Activity()
            ..meters = 2000
            ..totalactivitytime = Duration(minutes: 19)
            ..date = DateTime(2021, DateTime.may, 14),
        ],
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 10.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 10
        ..beginday = DateTime(2021, DateTime.may, 11)
        ..endday = DateTime(2022, DateTime.may, 31)
        ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 5.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 5
        ..beginday = DateTime(2021, 5, 11)
        ..endday = DateTime(2021, 5, 11)
        ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..finished = false
        ..title = "Marathon"
        ..distance = 2.0
        ..duration = Duration(minutes: 30)
        ..doneMaxDistance = 1.7
        ..beginday = DateTime(2021, 5, 11)
        ..endday = DateTime(2021, 5, 11)
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
