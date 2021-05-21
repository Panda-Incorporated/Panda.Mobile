import 'package:flutter/material.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Pages/AuthenticationPage.dart';
import 'package:panda/Pages/Home.dart';
import 'package:panda/Providers/ApiProvider.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/Logo.dart';

class StartPage extends StatefulWidget {
  final Function onDone;

  const StartPage({Key key, this.onDone}) : super(key: key);
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
    if (res != null) {
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
    } else {
      loading = false;
      done = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Container(
                      child: Logo(),
                      height: 188,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin:
                    EdgeInsets.only(top: 20, left: 15, bottom: 12, right: 15),
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(),
                                controller: controller,
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                    hintText: 'How do we call you?...'),
                              ),
                              Container(
                                height: 15,
                              ),
                              Text(
                                  "This app uses FitBit to access your activities. Sign in using your FitBit account below."),
                            ],
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OutlinedButton(
                                  child: Text("Next"),
                                  onPressed: () {
                                    if (widget.onDone != null) widget.onDone();
                                  })
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
