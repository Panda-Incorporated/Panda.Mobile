import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Providers/DBProvider.dart';

class GoalProvider {
  static Future<List<Goal>> getTempGoals() async {
    //NIET GOAL 1 AANPASSEN IS TEST UNIT
    return [
      Goal()
        ..title = "Wielrennen"
        ..distance = 7200.0
        ..duration = Duration(minutes: 19)
        ..beginday = DateTime(2021, DateTime.may, 20)
        ..endday = DateTime(2021, DateTime.may, 31),
    ];
  }

  static List<Activity> getTempActivitiesByGoal(int goalId) {
    return [
      // Activity()
      //   ..distance = 1001
      //   ..duration = Duration(minutes: 10)
      //   ..goalId = goalId
      //   ..name = "Activiteit 1"
      //   ..date = DateTime(2021, DateTime.may, 11),
      // Activity()
      //   ..distance = 1002
      //   ..duration = Duration(minutes: 9, seconds: 50)
      //   ..goalId = goalId
      //   ..name = "Activiteit 2"
      //   ..date = DateTime(2021, DateTime.may, 17),
      // Activity()
      //   ..distance = 1003
      //   ..duration = Duration(minutes: 9, seconds: 20)
      //   ..goalId = goalId
      //   ..name = "Activiteit 3"
      //   ..date = DateTime(2021, DateTime.may, 18),
      Activity()
        ..distance = 5490
        ..duration = Duration(minutes: 19)
        ..goalId = goalId
        ..name = "Activiteit 4"
        ..date = DateTime(2021, DateTime.may, 20),
      Activity()
        ..distance = 5500
        ..duration = Duration(minutes: 19)
        ..goalId = goalId
        ..name = "Activiteit 4"
        ..date = DateTime(2021, DateTime.may, 21),
      Activity()
        ..distance = 6400
        ..duration = Duration(minutes: 19)
        ..goalId = goalId
        ..name = "Activiteit 4"
        ..date = DateTime(2021, DateTime.may, 22),
      Activity()
        ..distance = 6600
        ..duration = Duration(minutes: 19)
        ..goalId = goalId
        ..name = "Activiteit 4"
        ..date = DateTime(2021, DateTime.may, 23),
      Activity()
        ..distance = 6900
        ..duration = Duration(minutes: 19)
        ..goalId = goalId
        ..name = "Activiteit 4"
        ..date = DateTime(2021, DateTime.may, 25),
      // Activity()
      //   ..distance = 7180
      //   ..duration = Duration(minutes: 19)
      //   ..goalId = goalId
      //   ..name = "Activiteit 4"
      //   ..date = DateTime(2021, DateTime.may, 30),
      // Activity()
      //   ..distance = 7200
      //   ..duration = Duration(minutes: 19)
      //   ..goalId = goalId
      //   ..name = "Activiteit 4"
      //   ..date = DateTime(2021, DateTime.may, 31)
    ];
  }

  static Future<List<Goal>> getGoals() async {
    return await DBProvider.helper.getGoals();
  }
}
