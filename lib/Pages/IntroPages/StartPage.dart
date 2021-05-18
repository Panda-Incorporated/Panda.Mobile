import 'package:flutter/material.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Pages/AuthenticationPage.dart';
import 'package:panda/Pages/Home.dart';
import 'package:panda/Providers/ApiProvider.dart';
import 'package:panda/Providers/DBProvider.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool loading = false;
  TextEditingController controller;
  String username;
  bool done = false;
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
    var authstate = await ApiProvider.getAccessToken(res);

    username = controller.text;
    if (username != null) {
      await DBProvider.helper.updateAuthState(AuthState.fill(
          accessToken: authstate.accessToken,
          refreshToken: authstate.refreshToken,
          expires: authstate.expires,
          username: username));
      loading = false;
      done = true;
      setState(() {});
    } else {
      loading = false;
      done = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!loading && !done) ...[
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
          ] else if (!loading && done) ...[
            Text(
                "Thanks for signing in $username, click next to continue setting up."),
            OutlinedButton(
                child: Text("Next"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                })
          ]
        ],
      ),
    );
  }
}
