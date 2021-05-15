import 'package:panda/Models/Activity.dart';

class ActivityProvider {
  static List<Activity> getActivity() {
    //TODO: NIET EERSTE TWEE ACTIVITIES AANPASSEN ZIJN TEST UNITS
    return [
      Activity()
        ..date = DateTime(2021, 5, 11)
        ..meters = 1000
        ..totalactivitytime = Duration(minutes: 6, seconds: 10),
      Activity()
        ..date = DateTime(2021, 5, 11)
        ..meters = 1000
        ..totalactivitytime = Duration(minutes: 6, seconds: 10),
    ];
  }

  static double getSecondsPerKilometer(Activity activity) {
    //sec/km van activity
    return activity.totalactivitytime.inSeconds / activity.meters * 1000;
  }
}
