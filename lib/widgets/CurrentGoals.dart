import 'package:flutter/material.dart';
import 'package:panda/DataProvider.dart/GoalProvider.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/widgets/GoalItem.dart';

class ShowGoals extends StatelessWidget {
  const ShowGoals({
    Key key,
    this.currentGoals,
  }) : super(key: key);

  final List<Goal> currentGoals;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var goal in currentGoals ?? [])
        if (!goal.finished)
          ListItem(
            title: goal.title,
            subTitle: goal.getString() ?? "",
            percentage: GoalProvider.getPercentage(goal).toInt(),
          )
        else
          ListItem(
            title: goal.title,
            subTitle: goal.getString() ?? "",
            percentage: GoalProvider.getPercentage(goal).toInt(),
          )
    ]);
  }
}
