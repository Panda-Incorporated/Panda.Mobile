import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Pages/PlanningPage.dart';
import 'package:panda/Pages/SeePredictionLargePage.dart';
import 'package:panda/Pages/ShowActivities.dart';
import 'package:panda/widgets/GoalSummary.dart';
import 'package:panda/widgets/ShowGraph.dart';
import 'package:panda/widgets/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'ActivitySelectionPage.dart';

class GoalSummaryPage extends StatefulWidget {
  final Goal goal;

  const GoalSummaryPage({Key key, @required this.goal}) : super(key: key);

  @override
  _GoalSummaryPageState createState() => _GoalSummaryPageState();
}

class _GoalSummaryPageState extends State<GoalSummaryPage> {
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    percentage = await widget.goal.getPercentage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          Column(
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
                    percent: percentage,
                    progressColor: Colors.green[800],
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    center: Text(
                      "${(percentage * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              GoalSummary(goal: widget.goal),

              Padding(
                // buiten het scherm en iets meer onder de 2,5 uur
                padding: EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 8.0, top: 18.0),
                child: Column(
                  children: [
                    FullPageButton(
                      title: "Grafiek weergeven",
                      onTap: SeePredictionLargePage(goal: widget.goal),
                    ),
                    FullPageButton(
                      title: "Activiteiten",
                      buttonTitle: "Activiteiten bekijken",
                      onTap: ShowActivitiesPage(
                        goal: widget.goal,
                      ),
                    ),
                    FullPageButton(
                      buttonTitle: "Activiteit toevoegen",
                      onTap: ActivitySelectionPage(),
                    ),
                    FullPageButton(
                      title: "Doelstellingen",
                      buttonTitle: "Doelstellingen weergeven",
                      onTap: PlanningPage(goal: widget.goal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
