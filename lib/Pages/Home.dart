import 'package:flutter/material.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Pages/GoalSummaryPage.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/widgets/CurrentGoals.dart';
import 'package:panda/widgets/Logo.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthState authState;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    authState = await DBProvider.helper.getAuthState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 168,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              ShowGoals(
                onGoalSelected: (goal) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GoalSummaryPage(goal: goal)),
                  );
                },
                currentGoals:
                    GoalProvider.getGoals().where((e) => !e.finished).toList(),
              ),
            ],
          ),
        ),
        // Text("${GoalProvider.getGoals()[0].getPercentage()}"),

        Container(
          height: 168,
          child: ListView(padding: const EdgeInsets.all(0), children: [
            ShowGoals(
              // onGoalSelected: (goal) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => GoalSummaryPage(goal: goal)),
              //   );
              // },
              currentGoals:
                  GoalProvider.getGoals().where((e) => e.finished).toList(),
            ),
          ]),
        ),
      ],
    );
  }
}
