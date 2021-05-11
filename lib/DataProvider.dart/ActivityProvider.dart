import 'package:panda/Models/Activity.dart';

class ActivityProvider {
  static List<Activity> getActivity() {
    return [
      Activity()
        ..date = DateTime(2021, 5, 11)
        ..meters = 1000
        ..seconds = 370,
      Activity()
        ..date = DateTime(2021, 5, 11)
        ..meters = 1000
        ..seconds = 370,
    ];
  }

  static double getSecondsPerKilometer(Activity activity) {
    return activity.seconds / activity.meters * 1000;
  }
}
