import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondScreen extends StatelessWidget {
  final nameHolder;
  final classHolder;
  final numberHolder;

  SecondScreen(
      {Key key, @required this.nameHolder, this.classHolder, this.numberHolder})
      : super(key: key);

  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Activity Screen"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text(
                'Distance = ' + nameHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'Student Class = ' + classHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'Time = ' + numberHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              RaisedButton(
                onPressed: () => goBack(context),
                color: Colors.lightBlue,
                textColor: Colors.white,
                child: Text('Go Back To Previous Screen'),
              )
            ]));
  }
}
