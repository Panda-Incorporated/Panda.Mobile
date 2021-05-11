import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda/DataProvider.dart/GoalProvider.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/widgets/ShowGraph.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalSummaryPage extends StatefulWidget {
  final Goal goal;

  const GoalSummaryPage({Key key, @required this.goal}) : super(key: key);
  @override
  _GoalSummaryPageState createState() => _GoalSummaryPageState();
}

class _GoalSummaryPageState extends State<GoalSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          // om het een plek te geven. Kan ook misschien met margin
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 4.0,
                backgroundColor: Colors.green[100],
                percent: widget.goal.getPercentage() / 100,
                progressColor: Colors.green[800],
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                center: Text(
                  "${widget.goal.getPercentage() / 100}%",
                  style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          Column(
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
                  "${widget.goal.doneMaxDistance} km van ${widget.goal.distance} km"),
              Text(
                "in",
                style: TextStyle(fontSize: 12),
              ),
              Text("${widget.goal.doneMaxDistance} minuten"),
            ],
          ),

          // Eerst volgende activiteit
          Padding(
            // buiten het scherm en iets meer onder de 2,5 uur
            padding: EdgeInsets.only(
                left: 12.0, right: 12.0, bottom: 8.0, top: 18.0),
            child: Column(
              children: [
                ShowGraph(data: "Voorspelling"),
                ShowGraph(data: "Voortgang")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
