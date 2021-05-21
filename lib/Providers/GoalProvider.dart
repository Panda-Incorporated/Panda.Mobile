import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Providers/DBProvider.dart';

class GoalProvider {
  static Future<List<Goal>> getTempGoals() async {
    //NIET GOAL 1 AANPASSEN IS TEST UNIT
    return [
      Goal()
        ..title = "Marathon"
        ..distance = 1000
        ..duration = Duration(minutes: 7, seconds: 39)
        ..beginday = DateTime(2021, DateTime.may, 11)
        ..endday = DateTime(2021, DateTime.may, 31),
      Goal()
        ..title = "Marathon"
        ..distance = 10000.0
        ..duration = Duration(minutes: 30)
        // ..doneMaxDistance = 10
        ..beginday = DateTime(2021, DateTime.may, 11)
        ..endday = DateTime(2022, DateTime.may, 31),
      //    ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..title = "Marathon"
        ..distance = 5000.0
        ..duration = Duration(minutes: 30)
        //   ..doneMaxDistance = 5
        ..beginday = DateTime(2021, 5, 11)
        ..endday = DateTime(2021, 5, 11),
      //    ..doneMaxDuration = Duration(minutes: 30),
      Goal()
        ..title = "Marathon"
        ..distance = 2000.0
        ..duration = Duration(minutes: 30)
        //   ..doneMaxDistance = 1.7
        ..beginday = DateTime(2021, 5, 11)
        ..endday = DateTime(2021, 5, 11)
      //  ..doneMaxDuration = Duration(minutes: 30)
    ];
  }

  static List<Activity> getTempActivitiesByGoal(int goalId) {
    return [
      Activity()
        ..distance = 1001
        ..duration = Duration(minutes: 10)
        ..goalId = goalId
        ..name = "Activiteit 1"
        ..date = DateTime(2021, DateTime.may, 11),
      Activity()
        ..distance = 1002
        ..duration = Duration(minutes: 9, seconds: 50)
        ..goalId = goalId
        ..name = "Activiteit 2"
        ..date = DateTime(2021, DateTime.may, 17),
      Activity()
        ..distance = 1003
        ..duration = Duration(minutes: 9, seconds: 20)
        ..goalId = goalId
        ..name = "Activiteit 3"
        ..date = DateTime(2021, DateTime.may, 18),
      Activity()
        ..distance = 1004
        ..duration = Duration(minutes: 8, seconds: 30)
        ..goalId = goalId
        ..name = "Activiteit 4"
        ..date = DateTime(2021, DateTime.may, 23)
    ];
  }

  static Future<List<Goal>> getGoals() async {
    return await DBProvider.helper.getGoals();
  }

  static double getPercentage(Goal goal) {
    return 0.1;
  }
}
