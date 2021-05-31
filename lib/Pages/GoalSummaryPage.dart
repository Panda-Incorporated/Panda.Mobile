import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Pages/PlanningPage.dart';
import 'package:panda/Pages/SeePredictionLargePage.dart';
import 'package:panda/Pages/ShowActivities.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/Utils/Notifications.dart';
import 'package:panda/Utils/ValueParser.dart';
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

class _GoalSummaryPageState extends State<GoalSummaryPage> with RouteAware {
  double percentage = 0.0;
  String activity = "";
  bool loading = false;
  int meters = 0;

  @override
  void didPopNext() {
    print("didPopNext");
    if (mounted) {
      refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  refresh() async {
    percentage = await widget.goal.getPercentage();
    print("fresehd");
    setState(() {});
  }

  getData() async {
    setState(() {
      loading = true;
    });
    percentage = await widget.goal.getPercentage();
    activity = await widget.goal.getLastactivity();

    meters = await widget.goal.getMetersToRun();

    setState(() {
      loading = false;
    });
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
        Notifications.show(context, text: "Activiteit is toegevoegd");
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      Notifications.show(context,
          text: 'Activiteit kon niet worden toegevoegd.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : activity != null && activity.length > 0
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
                              percent: percentage,
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
                                      "Eerstvolgende activiteit: ",
                                      "Vanaf $activity eenmalig:",
                                      "${ValueParser.distance(meters)} meter"),
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
                                onTap:
                                    SeePredictionLargePage(goal: widget.goal),
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
                              FullPageButtonBase(
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Let op!'),
                                    content: const Text(
                                        'Weet u zeker dat u dit doel met alle gekoppelde activiteiten wilt verwijderen?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Nee'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text(
                                                  'Doel wordt verwijderd'),
                                              content: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          );
                                          await DBProvider.helper
                                              .removeGoal(widget.goal);

                                          await DBProvider.helper
                                              .removeActivityByGoal(
                                                  widget.goal);
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        },
                                        child: const Text('Ja'),
                                      ),
                                    ],
                                  ),
                                ),
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
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  padding: const EdgeInsets.only(
                      top: 130.0, left: 10, right: 10, bottom: 130),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FullPageButton(
                            buttonTitle: "Activiteit toevoegen",
                            onTap: ActivitySelectionPage(
                              onSelected: onActivitySelected,
                            ),
                            title:
                                "U heeft nog geen nulmeting toegevoegd aan het doel",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class TomorrowSummary extends StatelessWidget {
  TomorrowSummary(this.date, this.goal, this.distance);

  final String date;
  final String goal;
  final String distance;

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
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            //"{planning.distance} km in planning.duration minuten"
            "" + goal,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Glyphicon.circle,
                  size: 8.0,
                ),
              ),
              Text(
                //"{planning.distance} km in planning.duration minuten"
                distance,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
