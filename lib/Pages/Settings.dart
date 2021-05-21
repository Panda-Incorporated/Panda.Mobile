import 'package:flutter/material.dart';
import 'package:panda/Pages/AuthenticationPage.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/Providers/GoalProvider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String code;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            child: Column(
              children: [
                Text("Settings"),
                OutlinedButton(
                    child: Text("Authenticate"),
                    onPressed: () async {
                      var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthenticationPage()),
                      );
                      code = res.toString();
                      setState(() {});
                    }),
                Text(code ??
                    "No code yet authenticate first"), //todo: we can use this to talk to the fitbit api and get an accestoken
              ],
            ),
          ),
          OutlinedButton(
              onPressed: () async {
                for (var goal in await GoalProvider.getTempGoals()) {
                  var id = await DBProvider.helper.insertGoal(goal);
                  for (var act in GoalProvider.getTempActivitiesByGoal(id)) {
                    await DBProvider.helper.insertActivity(act);
                  }
                }
              },
              child: Text("Fill database with 3 goals")),
          Text(" warning dont touch more then once"),
        ]),
      ],
    );
  }
}
