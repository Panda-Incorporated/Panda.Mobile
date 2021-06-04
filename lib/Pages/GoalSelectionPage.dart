import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/main.dart';
import 'package:panda/widgets/CurrentGoals.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/widgets/NothingToDisplay.dart';

class GoalSelectionPage extends StatefulWidget {
  const GoalSelectionPage({Key key, this.onGoalSelected}) : super(key: key);
  final Function(Goal) onGoalSelected;
  @override
  _GoalSelectionPageState createState() => _GoalSelectionPageState();
}

class _GoalSelectionPageState extends State<GoalSelectionPage> {
  Goal currentGoal;
  List<Goal> goals;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getGoals();
  }

  getGoals() async {
    setState(() {
      loading = true;
    });
    goals = (await GoalProvider.getGoals()).where((e) => !e.finished).toList();
    setState(() {
      loading = false;
    });
  }

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
                "Kies een doel:",
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
                loading
                    ? Center(child: CircularProgressIndicator())
                    : goals != null && goals.length > 0
                        ? ShowGoals(
                            onGoalSelected: (goal) {
                              currentGoal = goal;
                              if (widget.onGoalSelected != null) {
                                widget.onGoalSelected(goal);
                              }
                            },
                            currentGoals: goals,
                          )
                        : NothingToDisplay()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
