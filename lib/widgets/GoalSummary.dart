import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Utils/DateTimeExtension.dart';
import 'package:panda/Utils/ValueParser.dart';

class GoalSummary extends StatefulWidget {
  final Goal goal;

  const GoalSummary({Key key, this.goal}) : super(key: key);

  @override
  _GoalSummaryState createState() => _GoalSummaryState();
}

class _GoalSummaryState extends State<GoalSummary> {
  double percentage = 0.0;
  double distance1 = 0.0;
  String finalDistance = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var temp = await widget.goal.activities();
    if (temp != null && temp.length > 0) {
      distance1 =
          await widget.goal.activities().then((value) => value.last.distance);
      percentage = await widget.goal.getPercentage();
      finalDistance =
          ValueParser.distance((widget.goal.distance * percentage).toInt());
      print(finalDistance);
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
        Text(
            "${widget.goal.beginday.ToInput("03/02/20")} - ${widget.goal.endday.ToInput("03/02/21")}"),
        const SizedBox(height: 10),
        Icon(
          Icons.outlined_flag,
        ),
        Text(
            "$finalDistance van ${ValueParser.distance(widget.goal.distance.toInt())}"),
        Text(
          "in",
          style: TextStyle(fontSize: 12),
        ),
        Text("${ValueParser.duration(widget.goal.duration)}"),
      ],
    );
  }
}
