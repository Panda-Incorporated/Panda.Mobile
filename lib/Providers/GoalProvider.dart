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
        ..duration = Duration(minutes: 7, seconds: 39)
        ..goal = 500
        ..beginday = DateTime(2021, DateTime.may, 11)
        ..endday = DateTime(2021, DateTime.may, 31)
        ..doneActivity = [
          Activity()
            ..distance = 1000
            ..duration = Duration(minutes: 10)
            ..date = DateTime(2021, DateTime.may, 11),
          Activity()
            ..distance = 1000
            ..duration = Duration(minutes: 9, seconds: 50)
            ..date = DateTime(2021, DateTime.may, 17),
          Activity()
            ..distance = 1000
            ..duration = Duration(minutes: 9, seconds: 20)
            ..date = DateTime(2021, DateTime.may, 18),
          Activity()
            ..distance = 1000
            ..duration = Duration(minutes: 8, seconds: 30)
            ..date = DateTime(2021, DateTime.may, 23),
        ],
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 10.0
        ..duration = Duration(minutes: 30)
        // ..doneMaxDistance = 10
        ..beginday = DateTime(2021, DateTime.may, 11)
        ..endday = DateTime(2022, DateTime.may, 31),
      //    ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..finished = true
        ..title = "Marathon"
        ..distance = 5.0
        ..duration = Duration(minutes: 30)
        //   ..doneMaxDistance = 5
        ..beginday = DateTime(2021, 5, 11)
        ..endday = DateTime(2021, 5, 11),
      //    ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..finished = false
        ..title = "Marathon"
        ..distance = 2.0
        ..duration = Duration(minutes: 30)
        //   ..doneMaxDistance = 1.7
        ..beginday = DateTime(2021, 5, 11)
        ..endday = DateTime(2021, 5, 11)
      //  ..doneMaxDuration = Duration(minutes: 30)
    ];
  }

  static double getPercentage(Goal goal) {
    return 0.1;
  }
}
