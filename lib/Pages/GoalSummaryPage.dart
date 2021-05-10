import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda/widgets/ShowGraph.dart';
import 'package:panda/widgets/TomorrowSummary.dart';

class GoalSummaryPage extends StatefulWidget {
  @override
  _GoalSummaryPageState createState() => _GoalSummaryPageState();
}

class _GoalSummaryPageState extends State<GoalSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          // om het een plek te geven. Kan ook misschien met margin
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Colors.green[700], width: 6.0),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Center(
                    child: Text(
                      "75%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "{Naam van doel}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.outlined_flag,
              ),
              Text("18,75 km van 25 km"),
              Text(
                "in",
                style: TextStyle(fontSize: 12),
              ),
              Text("2,5 uur"),
            ],
          ),

          // Eerst volgende activiteit
          Padding(
            // buiten het scherm en iets meer onder de 2,5 uur
            padding: EdgeInsets.only(
                left: 12.0, right: 12.0, bottom: 8.0, top: 18.0),
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Eerstvolgende activiteit",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 12.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TomorrowSummary("morgen 8 april", "5 km in 30 minuten"),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 16.0),
                          child: Text(
                            "Meer weergeven",
                            style: TextStyle(
                              color: Colors.cyanAccent[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShowGraph(data: "Voorspelling"),
                ShowGraph(data: "Voortgang")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
