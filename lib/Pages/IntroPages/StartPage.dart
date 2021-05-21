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
  final _formKey = GlobalKey<FormState>();
  bool everythingDone = false;
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
        everythingDone = true;
        setState(() {});
      } else {
        loading = false;
        done = false;
        everythingDone = false;
        setState(() {});
      }
    } else {
      loading = false;
      done = false;
      everythingDone = false;
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
                              Form(
                                key: _formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: TextFormField(
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Naam is verplicht";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(),
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Naam',
                                    border: OutlineInputBorder(),
                                    hintText: 'Hoe mogen we je noemen?...',
                                  ),
                                ),
                              ),
                              Container(
                                height: 15,
                              ),
                              Text(
                                  "This app uses FitBit to access your activities. Sign in using your FitBit account below."),
                              Center(
                                child: OutlinedButton(
                                    child: Text("Inloggen via Fitbit"),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        saveData();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    'Er is nog geen naam ingevuld')));
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              everythingDone
                                  ? OutlinedButton(
                                      child: Text("Volgende"),
                                      onPressed: () {
                                        if (widget.onDone != null)
                                          widget.onDone();
                                      })
                                  : Container(),
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
