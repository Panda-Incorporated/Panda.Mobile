import 'package:flutter/material.dart';
import 'package:panda/DataProvider.dart/GoalProvider.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Utils/Pair.dart';
import 'package:panda/widgets/ListItem.dart';

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
          ListItem.extended(
            title: goal.title,
            subTitle: goal.getString() ?? "",
            percentage: GoalProvider.getPercentage(goal).toInt(),
            extendedItems: [
              for (var planning in goal.listPlanning ?? [])
                Pair(planning.title, planning.getString())
            ],
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
