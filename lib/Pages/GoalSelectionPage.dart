import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/widgets/CurrentGoals.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/widgets/NothingToDisplay.dart';

class GoalSelectionPage extends StatefulWidget {
  final String title;
  const GoalSelectionPage({Key key, this.onGoalSelected, this.title})
      : super(key: key);
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
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title ?? ""),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        body: Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                child: Logo(),
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Kies uit lopende doelen",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
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
                ))));
  }
}
