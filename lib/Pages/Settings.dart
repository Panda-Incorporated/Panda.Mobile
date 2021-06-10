import 'package:flutter/material.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Pages/AuthenticationPage.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/Providers/GoalProvider.dart';
import 'package:panda/main.dart';
import 'package:panda/widgets/NewGoalInputField.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller;
  AuthState authState;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();

    loadData();
  }

  onEditUsername() async {
    if (controller.text != authState.username) {
      authState.username = controller.text;
      await DBProvider.helper.updateAuthState(authState);
      print("saved username");
      FocusScope.of(context).unfocus();
    }
  }

  loadData() async {
    authState = await DBProvider.helper.getAuthState();
    controller.text = authState.username;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(mainAxisSize: MainAxisSize.max, children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Instellingen",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  NewGoalInputAndTextField(
                      onEdittingComplete: onEditUsername,
                      controller: controller,
                      labelText: "Voer gebruikersnaam in",
                      textString: "Gebruikersnaam wijzigen"),

                  //todo: we can use this to talk to the fitbit api and get an accestoken (Reindert)
                ],
              ),
            ),
            Divider(),
            OutlinedButton(
                onPressed: () async {
                  for (var goal in await GoalProvider.getTempGoals()) {
                    var id = await DBProvider.helper.insertGoal(goal);
                    for (var act in GoalProvider.getTempActivitiesByGoal(id)) {
                      await DBProvider.helper.insertActivity(act);
                    }
                  }
                },
                child: Text("Fill database with 1 goal")),
            OutlinedButton(
                onPressed: () async {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Let op!'),
                      content: const Text(
                          'Weet u zeker dat u alle data binnen deze app wilt verwijderen? Alle opgeslagen gegevens zoals doelen, activiteiten, gebruikersnaam etc. gaan verloren.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Nee'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await DBProvider.helper.deleteDb();
                            await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => InitialPage()));
                          },
                          child: const Text('Ja'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text("Reset app")),
          ]),
        ],
      ),
    );
  }
}
