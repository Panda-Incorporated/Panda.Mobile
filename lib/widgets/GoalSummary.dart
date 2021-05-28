import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';

class GoalSummary extends StatefulWidget {
  final Goal goal;

  const GoalSummary({Key key, this.goal}) : super(key: key);

  @override
  _GoalSummaryState createState() => _GoalSummaryState();
}

class _GoalSummaryState extends State<GoalSummary> {
  int time = 1;
  double percentage = 0.0;
  double distance1 = 19.0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var temp = await widget.goal.activities();
    if (temp != null && temp.length > 0) {
      time = await widget.goal
          .activities()
          .then((value) => value.last.getSecondsPerKilometer());
      distance1 =
          await widget.goal.activities().then((value) => value.last.distance);
      percentage = await widget.goal.getPercentage();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            widget.goal.title,
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
            "${(widget.goal.distance * percentage).toInt()} m van ${widget.goal.distance.toInt()} m"),
        Text(
          "in",
          style: TextStyle(fontSize: 12),
        ),
        Text("${widget.goal.duration.inMinutes} minuten"),
      ],
    );
  }
}
