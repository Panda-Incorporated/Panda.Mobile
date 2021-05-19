import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';

class ShowPlanning extends StatelessWidget {
  const ShowPlanning({Key key, this.planner, this.goal}) : super(key: key);
  final String planner;
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    var multiplier = [1.2, 1.0, 0.8];
    var kmsdif = [-4, 0, 4];
    var days = goal.endday.difference(goal.beginday).inDays;
    var i = DateTime.now().difference(goal.beginday).inDays;
    var y = (goal.goal - goal.getMesurement()) / sqrt(days) * sqrt(i) +
        goal.getMesurement();
    return Column(children: [
      for (int i = 0; i < 3; i++)
        if (this.planner == "Time")
          PlanningItem(
            Stars: i,
            text:
                "Loop ${((goal.duration.inMinutes * multiplier[i]) / 2).ceilToDouble()} minuten hard",
          )
        else if (this.planner == "Distance")
          PlanningItem(
            item: "Planner",
            Stars: i,
            text:
                "Loop ${(((goal.distance / 1000) * multiplier[i]) / 2)} kilometer hard",
          )
        else if (this.planner == "Nulmeting")
          PlanningItem(
            item: "Planner",
            Stars: i,
            text:
                "Loop gemiddeld ${y.ceilToDouble() + kmsdif[i]} sec/km over 3km",
          ),
    ]);
  }
}

class PlanningItem extends StatefulWidget {
  PlanningItem({
    Key key,
    this.item,
    this.Stars,
    this.text,
  }) : super(key: key);

  @override
  _PlanningItemState createState() => _PlanningItemState();
  final String item;
  final int Stars;
  final String text;
}

class _PlanningItemState extends State<PlanningItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {}, // TODO: SET Star TO CURRENT SUBGOAL
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(6))),

          // kleur knop
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // helemaal links helemaal rechts
                  children: [
                    Column(
                      //tekst datum en doel moeten onder elkaar
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                "{titel}",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                "${widget.text}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // %
                    Row(
                      children: [
                        for (int j = 3; j > widget.Stars; j--)
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
