// ! Sniellsie zijn goede code, holy shit deze man kan flutteren.
// * TODO Niels, error checks, overbodige code, date tijd aanpassen.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panda/Models/Goal.dart';

import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/widgets/NewGoalInputField.dart';
import 'package:panda/widgets/NewGoalInputDate.dart';
import 'package:panda/widgets/NewGoalInputDistance.dart';

class NewGoal extends StatefulWidget {
  @override
  _NewGoalState createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  var _goalName = new TextEditingController();
  var _distance = new TextEditingController();
  var _deadline = new TextEditingController();
  var _duration = new TextEditingController();

  Goal newGoal;

  double _titelFontSize = 25;
  double _textFontSize = 15;
  double _inputBoxHeight = 50;
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Container(
                child: Logo(),
                height: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Nieuw Doel',
                            style: TextStyle(
                              fontSize: _titelFontSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        NewGoalInputAndTextField(
                          controller: _goalName,
                          labelText: "Naam",
                          textString: 'Nieuw doel:',
                        ),
                        NewGoalInputDate(
                          onDateSelected: (d) {
                            selectedDate = d;
                          },
                          controller: _deadline,
                          labelText: "Datum",
                          keyboardType: TextInputType.number,
                          textString: "Deadline:",
                        ),
                        NewGoalInputDistance(
                          controller: _distance,
                          labelText: "Meters",
                          textString: "Afstand van de marathon:",
                        ),
                        NewGoalInputAndTextField(
                          controller: _duration,
                          labelText: "Minuten",
                          textString: "Gewenste looptijd",
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20, top: 5),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            child: RaisedButton(
                              child: Text(
                                "Maak doel aan!",
                                style: TextStyle(
                                  fontSize: _textFontSize,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              textColor: Colors.black,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () async => {
                                if (selectedDate != null)
                                  {
                                    newGoal = Goal()
                                      ..title = _goalName.text
                                      ..distance = double.parse(_distance.text)
                                      ..duration = Duration(
                                          minutes: int.parse(_duration.text))
                                      ..beginday = DateTime.now()
                                      ..endday = selectedDate,
                                    await DBProvider.helper.insertGoal(newGoal),
                                    Navigator.pop(context, newGoal),
                                  }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
