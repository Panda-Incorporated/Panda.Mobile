import 'package:flutter/material.dart';

class GoalSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "{Naam van doel}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Icon(
          Icons.outlined_flag,
        ),
        Text("18,75 km van 25 km"),
        Text(
          "in",
          style: TextStyle(fontSize: 12),
        ),
        Text("2,5 uur"),
      ],
    );
  }
}
