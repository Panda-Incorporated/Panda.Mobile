import 'package:flutter/material.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Models/models.dart';
import 'package:panda/Pages/GoalSummaryPage.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/widgets/CurrentGoals.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/widgets/NothingToDisplay.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthState authState;
  bool loading = false;
  List<Goal> goals;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      loading = true;
    });
    authState = await DBProvider.helper.getAuthState();
    goals = await GoalProvider.getGoals();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
              child: Text(
            "Lopende doelen",
            style: TextStyle(fontSize: 24.0),
          )),
        ),
        Container(
          child: Column(
            children: [
              loading
                  ? Center(child: CircularProgressIndicator())
                  : goals != null && goals.where((e) => !e.finished).length > 0
                      ? ShowGoals(
                          onGoalSelected: (goal) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GoalSummaryPage(goal: goal)),
                            );
                          },
                          currentGoals:
                              goals.where((e) => !e.finished).toList(),
                        )
                      : NothingToDisplay(),
            ],
          ),
        ),
        // Text("${GoalProvider.getGoals()[0].getPercentage()}"),
        Center(
            child: Text(
          "Afgeronde doelen",
          style: TextStyle(fontSize: 24.0),
        )),
        Container(
          child: Column(children: [
            loading
                ? Center(child: CircularProgressIndicator())
                : goals != null && goals.length > 0
                    ? ShowGoals(
                        onGoalSelected: (goal) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GoalSummaryPage(goal: goal)),
                          );
                        },
                        currentGoals: goals.where((e) => e.finished).toList())
                    : NothingToDisplay()
          ]),
        ),
      ],
    ));
  }
}
