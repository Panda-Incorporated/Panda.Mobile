// ! Sniellsie zijn tering goede code, holy shit deze man kan flutteren.
// * TODO Niels, max string length, error checks, datum aanklikken tabel, overbodige code.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/Pages/NewGoalInput.dart';
import 'package:panda/Pages/GoalSelectionPage.dart';
import 'package:panda/Pages/Home.dart';
import 'package:panda/main.dart';
import 'package:panda/widgets/GoalSummary.dart';
import 'NewGoalInput.dart';

class NewGoal extends StatefulWidget {
  @override
  _NewGoalState createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  var _goalName = new TextEditingController();
  var _distance = new TextEditingController();
  var _deadline = new TextEditingController();
  var _date = new TextEditingController();
  var _availability = new TextEditingController();

  Goal a;

  double _titelFontSize = 25;
  double _textFontSize = 15;
  double _inputBoxHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5, bottom: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nieuw Doel',
                          style: TextStyle(
                            fontSize: _titelFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    // * Type doel text
                    Container(
                      margin: EdgeInsets.only(left: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nieuw doel: ',
                        style: TextStyle(
                          fontSize: _textFontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      height: _inputBoxHeight,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _goalName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Naam',
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Deadline:',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: _textFontSize),
                        )),
                    Container(
                      height: _inputBoxHeight,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _deadline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Datum',
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Afstand:',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: _textFontSize),
                        )),
                    Container(
                      height: _inputBoxHeight,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _distance,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kilometers',
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tijd:',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: _textFontSize),
                        )),
                    Container(
                      height: _inputBoxHeight,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _date,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Uren:Minuten',
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Beschikbaarheid:',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: _textFontSize),
                        )),
                    Container(
                      height: _inputBoxHeight,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _availability,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Aantal dagen',
                        ),
                      ),
                    ),
                    // * button

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
                          onPressed: () => {
                            a = Goal()
                              ..title = _goalName.text
                              ..distance = double.parse(_distance.text)
                              ..duration = Duration(minutes: 7, seconds: 39)
                              ..beginday = DateTime(2021, DateTime.may, 11)
                              ..endday = DateTime(2021, DateTime.may, 31),
                            DBProvider.helper.insertGoal(a),
                            print(a),
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
