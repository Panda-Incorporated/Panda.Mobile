import 'package:flutter/material.dart';

class TomorrowSummary extends StatelessWidget {
  TomorrowSummary(this.date, this.goal);

  final String date;
  final String goal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // "{planning.title} {planning.date?} "
          date,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          //"{planning.distance} km in planning.duration minuten"
          "- " + goal,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
