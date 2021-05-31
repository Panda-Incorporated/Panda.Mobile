import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Pages/AuthenticationPage.dart';
import 'package:panda/Pages/GoalSummaryPage.dart';
import 'package:panda/Providers/ApiProvider.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/main.dart';
import 'package:panda/widgets/CurrentGoals.dart';
import 'package:panda/widgets/NothingToDisplay.dart';
import 'package:panda/widgets/TextListItem.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware {
  AuthState authState;
  bool loading = false;
  List<Goal> goals;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    print("didPopNext");
    if (mounted) {
      loadData();
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    ApiProvider.needsReauthentication.removeListener(showSnackBar);
    super.dispose();
  }

  showSnackBar() {
    if (ApiProvider.needsReauthentication.value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(days: 1),
          action: SnackBarAction(
            onPressed: () async {
              await saveData();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            label: "Klik hier",
          ),
          behavior: SnackBarBehavior.floating,
          content: Text('Inlogsessie verlopen probeer opnieuw in te loggen')));
    }
  }

  @override
  void initState() {
    super.initState();
    ApiProvider.needsReauthentication.addListener(showSnackBar);
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

  saveData() async {
    setState(() {
      loading = true;
    });
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationPage()),
    );
    if (res != null) {
      var authstate = await ApiProvider.getAccessToken(res);
      if (authState != null) {
        await DBProvider.helper.updateAuthState(AuthState.fill(
            accessToken: authstate.accessToken,
            refreshToken: authstate.refreshToken,
            expires: authstate.expires,
            username: authState.username));
        await loadData();
        setState(() {});
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: ApiProvider.needsReauthentication,
            builder: (c, v, _) {
              if (v) {
                return TextListItem(
                  title: "Inlogsessie is verlopen",
                  subTitle: "Klik hier om opnieuw in te loggen",
                  extra: Icon(
                    Glyphicon.exclamation_triangle,
                    color: Colors.orange,
                  ),
                  onTap: () {
                    saveData();
                  },
                );
              } else {
                return Container();
              }
            }),

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
                : goals != null && goals.where((e) => e.finished).length > 0
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
