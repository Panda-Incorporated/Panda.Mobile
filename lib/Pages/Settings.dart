import 'package:flutter/material.dart';
import 'package:panda/Pages/AuthenticationPage.dart';

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
          )
        ]),
      ],
    );
  }
}
