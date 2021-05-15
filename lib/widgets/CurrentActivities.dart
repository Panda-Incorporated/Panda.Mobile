import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'ActivityItem.dart';

class ShowActivities extends StatelessWidget {
  const ShowActivities({
    Key key,
    this.currentActvities,
  }) : super(key: key);
//TODO Review vgm af
  final List<Activity> currentActvities;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var activity in currentActvities ?? [])
        ActivityItem(activity: activity)
    ]);
  }
}
