import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Pages/GiveStarScreen.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/widgets/CurrentGoals.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/widgets/widgets.dart';

class GoalSelectionPage extends StatefulWidget {
  final Activity act;

  const GoalSelectionPage({Key key, @required this.act}) : super(key: key);

  @override
  _GoalSelectionPageState createState() => _GoalSelectionPageState();
}

// TODO: Fitbitselection1 en Fitbitselection2 generiek maken zodat we maar 1 scherm nodig hebben voor twee widgets
class _GoalSelectionPageState extends State<GoalSelectionPage> {
  Goal currentGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            stretchTriggerOffset: 200,
            floating: true,
            bottom: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Kies uit doel:",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.zoomBackground],
              collapseMode: CollapseMode.pin,
              background: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Logo(),
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 300,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ShowGoals(
                  onGoalSelected: (goal) {
                    currentGoal = goal;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GiveStarPage(goal: goal, activity: widget.act)),
                    );
                  },
                  currentGoals: GoalProvider.getGoals()
                      .where((e) => !e.finished)
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
