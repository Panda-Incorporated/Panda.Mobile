import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Pages/PlanningPage.dart';
import 'package:panda/Pages/SeePredictionLargePage.dart';
import 'package:panda/Pages/ShowActivities.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/GoalSummary.dart';
import 'package:panda/widgets/ShowGraph.dart';
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
  String activity = "";

  int meters = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    percentage = await widget.goal.getPercentage();
    activity = await widget.goal.getLastactivity();

    meters = await widget.goal.getMetersToRun();

    setState(() {});
  }

  Future<void> onActivitySelected(Activity activity) async {
    try {
      if (widget.goal != null && activity != null) {
        activity.goalId = widget.goal.id;
        activity.distance = activity.distance * 1000;

        await DBProvider.helper.insertActivity(activity);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Activiteit is toegevoegd.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Activiteit kon niet worden toegevoegd.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: activity != null && activity.length > 0
          ? ListView(
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
                          percent: (percentage > 1.0
                                  ? 1.0
                                  : (percentage < 0 ? 0.0 : percentage))
                              .toDouble(),
                          progressColor: Colors.green[800],
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          center: Text(
                            "${(percentage * 100).toInt()}%",
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
                      padding: EdgeInsets.only(left: 12.0, top: 12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TomorrowSummary(
                                  "Eerst volgende keer: ",
                                  "vanaf $activity eenmalig:\n"
                                      "loop $meters meter hard"),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      // buiten het scherm en iets meer onder de 2,5 uur
                      padding: EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 8.0, top: 18.0),
                      child: Column(
                        children: [
                          FullPageButton(
                            title: "Voortgang",
                            buttonTitle: "Grafiek weergeven",
                            onTap: SeePredictionLargePage(goal: widget.goal),
                          ),
                          FullPageButton(
                            buttonTitle: "Doelstellingen weergeven",
                            onTap: PlanningPage(goal: widget.goal),
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
                            onTap: ActivitySelectionPage(
                              onSelected: onActivitySelected,
                            ),
                          ),
                          FullPageButton(
                            onTap: null,
                            title: "Doel verwijderen",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FullPageButton(
                    buttonTitle: "Activiteit toevoegen",
                    onTap: ActivitySelectionPage(),
                    title: "U heeft nog geen nulmeting toegevoegd aan het doel",
                  ),
                ],
              ),
            ),
    );
  }
}

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
          "" + goal,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
