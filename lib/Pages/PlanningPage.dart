import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/main.dart';
import 'package:panda/widgets/Logo.dart';

class PlanningPage extends StatefulWidget {
  final Goal goal;

  const PlanningPage({Key key, @required this.goal}) : super(key: key);

  @override
  _GiveStarPageState createState() => _GiveStarPageState();
}

class _GiveStarPageState extends State<PlanningPage> {
  List<double> program = [];
  List<Activity> activities = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    activities = await widget.goal.activities();
    var startpoint = DateTime.now().difference(widget.goal.beginday).inDays;
    var days = widget.goal.endday.difference(widget.goal.beginday).inDays;
    print(startpoint);
    var togo = days - startpoint;
    for (int i = 0; i < togo; i++) {
      // now- history
      var j = await getYbasedonX(widget.goal, i + startpoint);
      program.add(j);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var startpoint = DateTime.now().difference(widget.goal.beginday).inDays;
    var days = widget.goal.endday.difference(widget.goal.beginday).inDays;
    var togo = days - startpoint;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          stretch: true,
          stretchTriggerOffset: 200,
          floating: true,
          bottom: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [StretchMode.zoomBackground],
            collapseMode: CollapseMode.pin,
            background: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Logo(),
                ),
              ],
            ),
          ),
          expandedHeight: 250,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doelstellingen",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  for (int i = 0; i < togo; i++)
                    Litem(
                        // text: i % 2 == 0
                        //     ? "Loop gemiddeld ${program.length > 0 ? program[i].toInt() : 0} sec/km over 3km"
                        //     : i % 5 == 0
                        //         ? "active rustdag"
                        //         : "passvive rustdag",
                        text:
                            "Loop gemiddeld ${program.length > 0 ? program[i].toInt() : 0} sec/km over 3km",
                        titel:
                            "${DateFormat('EEEE dd-MM').format(DateTime.now().add(Duration(days: i)))}"),
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class Litem extends StatelessWidget {
  final String text;
  final String titel;

  const Litem({Key key, @required this.text, @required this.titel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Navigation()))
        },
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
                                "$titel",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                "$text",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
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

Future<double> getYbasedonX(Goal goal, int i) async {
  var mes = await goal.getMeasurement();
  var days = goal.endday.difference(goal.beginday).inDays;
  // print("amount of days $days");
  return ((goal.goal - mes) / sqrt(days) * sqrt(i) + mes);
}
