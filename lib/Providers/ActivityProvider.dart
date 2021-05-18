import 'package:panda/Models/Activity.dart';

class ActivityProvider {
  static List<Activity> getActivity() {
    //NIET EERSTE TWEE ACTIVITIES AANPASSEN ZIJN TEST UNITS
    return [
      Activity()
        ..date = DateTime(2021, 5, 11)
        ..distance = 1000
        ..duration = Duration(minutes: 6, seconds: 10),
      Activity()
        ..date = DateTime(2021, 5, 11)
        ..distance = 1000
        ..duration = Duration(minutes: 6, seconds: 10),
    ];
  }

  static double getSecondsPerKilometer(Activity activity) {
    //sec/km van activity
    return activity.duration.inSeconds / activity.distance * 1000;
  }
}
