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
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          stretch: true,
          stretchTriggerOffset: 200,
          floating: true,
          bottom: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: Text(
              "Welkom " + (authState?.username ?? ""),
              style: TextStyle(
                fontSize: 34,
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
                  child: Logo(),
                ),
              ],
            ),
          ),
          expandedHeight: 300,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lopende doelen:",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ShowGoals(
                    onGoalSelected: (goal) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoalSummaryPage(goal: goal)),
                      );
                    },
                    currentGoals: GoalProvider.getGoals()
                        .where((e) => !e.finished)
                        .toList(),
                  ),
                  Text("${GoalProvider.getGoals()[0].getPercentage()}"),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Afgeronde doelen:",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ShowGoals(
                    // onGoalSelected: (goal) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => GoalSummaryPage(goal: goal)),
                    //   );
                    // },
                    currentGoals: GoalProvider.getGoals()
                        .where((e) => e.finished)
                        .toList(),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
