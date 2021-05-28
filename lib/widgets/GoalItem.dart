import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';
import 'dart:math' as math;
import 'package:percent_indicator/circular_percent_indicator.dart';

class ListItem extends StatefulWidget {
  ListItem({Key key, this.goal, this.onTap}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
  final Goal goal;
  final Function onTap;
}

class _ListItemState extends State<ListItem> {
  double percentage = 0.1;
  String title = "";
  String subtitle = "";
  int distance = 0;
  int time = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    percentage = await widget.goal.getPercentage();
    title = widget.goal.title;
    distance = widget.goal.distance.toInt();
    time = widget.goal.duration.inMinutes;
    //subtitle = await widget.goal.getString();
    subtitle = "$distance m in $time min";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget
            .onTap, //navigeren naar goal summaary page en dan goal meegeven
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(6))),

          // kleur knop

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // helemaal links helemaal rechts
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      subtitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 5.0,
                  backgroundColor: Colors.white,
                  percent: percentage > 1.0
                      ? 1.0
                      : (percentage < 0 ? 0.0 : percentage),
                  progressColor: Colors.green,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  center: Text(
                    "${(percentage * 100).toInt()}",
                    style: TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
