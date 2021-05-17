import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';

class GoalSummary extends StatelessWidget {
  final Goal goal;

  const GoalSummary({Key key, this.goal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            goal.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Icon(
          Icons.outlined_flag,
        ),
        Text(
            "{km/s last activity door Tichel formule} km van ${goal.distance} km"),
        Text(
          "in",
          style: TextStyle(fontSize: 12),
        ),
        Text("${goal.duration.inMinutes} minuten"),
      ],
    );
  }
}
