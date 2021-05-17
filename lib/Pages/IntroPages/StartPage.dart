import 'package:flutter/material.dart';
import 'package:panda/Pages/AuthenticationPage.dart';
import 'package:panda/Providers/DBProvider.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool loading = false;
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  saveData() async {
    setState(() {
      loading = true;
    });
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationPage()),
    );
    DBProvider.helper.getDatabase();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!loading) ...[
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "How do we call you?..."),
          ),
          Text(
              "This app uses FitBit to access your activities. Sign in using your FitBit account below."),
          OutlinedButton(
              child: Text("Sign in using Fitbit"),
              onPressed: () {
                saveData();
              })
        ] else
          Text("Thanks for signing in, click next to continue setting up.")
      ],
    );
  }
}
