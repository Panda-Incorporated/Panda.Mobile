import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/main.dart';
import 'package:panda/widgets/Logo.dart';

class GiveStarPage extends StatefulWidget {
  final Goal goal;

  const GiveStarPage({Key key, @required this.goal}) : super(key: key);

  @override
  _GiveStarPageState createState() => _GiveStarPageState();
}

class _GiveStarPageState extends State<GiveStarPage> {
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
                    "Sportschema",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  for (int i = 0; i < togo; i++)
                    Litem(
                        text: i % 2 == 0
                            ? "Loop gemiddeld ${program.length > 0 ? program[i].toInt() : 0} sec/km over 3km"
                            : i % 5 == 0
                                ? "active rustdag"
                                : "passvive rustdag",
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
  print("amount of days $days");
  return ((goal.goal - mes) / sqrt(days) * sqrt(i) + mes);
}

// int amountOfStarsDistance(
//     int act_input, List<double> array, double goal_input) {
//   var array2 = array.reversed.toList();
//   List<double> marges = [];
//   for (int j = 0; j < array2.length; j++) {
//     marges.add(((goal_input * array2[j]) / 2));
//   }
//
//   var stars = 0;
//   for (int i = 0; i < marges.length; i++) {
//     if (marges[i] < act_input) {
//       print("sterren verhoogd want ${marges[i]} is lager dan $act_input");
//       stars++;
//     } else
//       print("sterren niet verhoogd want ${marges[i]} is hoger dan $act_input");
//   }
//   return stars;
// }
//
// int amountOfStarsTime(int act_input, List<double> array, int goal_input) {
//   var array2 = array.reversed.toList();
//   List<double> marges = [];
//   for (int j = 0; j < array2.length; j++) {
//     marges.add(((goal_input * array2[j]) / 2));
//   }
//
//   var stars = 0;
//   for (int i = 0; i < marges.length; i++) {
//     if (marges[i] < act_input) {
//       print("sterren verhoogd want ${marges[i]} is lager dan $act_input");
//       stars++;
//     } else
//       print("sterren niet verhoogd want ${marges[i]} is hoger dan $act_input");
//   }
//
//   return stars;
// }
//
// int amountOfStarsMPSEC(int act_input, List<int> array, int goal_input) {
//   var array2 = array.reversed.toList();
//   List<double> marges = [];
//   for (int j = 0; j < array2.length; j++) {
//     marges.add(goal_input.ceilToDouble() + array2[j]);
//   }
//
//   var stars = 0;
//   for (int i = 0; i < marges.length; i++) {
//     if (marges[i] > act_input) {
//       print("sterren verhoogd want $act_input is lager dan  ${marges[i]}");
//       stars++;
//     } else
//       print("sterren niet verhoogd want $act_input is hoger dan ${marges[i]}");
//   }
//   return stars;
// }

// import 'package:flutter/material.dart';
// import 'package:panda/Models/Goal.dart';
// import 'package:panda/widgets/CurrentPlanning.dart';
// import 'package:panda/widgets/Logo.dart';
//
// class PlanningPage extends StatefulWidget {
//   final Goal goal;
//
//   const PlanningPage({Key key, @required this.goal}) : super(key: key);
//
//   @override
//   _PlanningPageState createState() => _PlanningPageState();
// }
//
// class _PlanningPageState extends State<PlanningPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(slivers: [
//         SliverAppBar(
//           stretch: true,
//           stretchTriggerOffset: 200,
//           floating: true,
//           bottom: AppBar(
//             elevation: 0.0,
//             backgroundColor: Colors.transparent,
//             centerTitle: false,
//             title: Text(
//               "Welkom Panda",
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           elevation: 0.0,
//           backgroundColor: Colors.white,
//           flexibleSpace: FlexibleSpaceBar(
//             stretchModes: [StretchMode.zoomBackground],
//             collapseMode: CollapseMode.pin,
//             background: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Logo(),
//                 ),
//               ],
//             ),
//           ),
//           expandedHeight: 300,
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate([
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Duur doelen:",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   ShowPlanning(planner: "Time", goal: widget.goal),
//                   //  Text("${GoalProvider.getGoals()[0].getPercentage()}"),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Afstands doelen:",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   ShowPlanning(planner: "Distance", goal: widget.goal),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Nulmetingen:",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   ShowPlanning(planner: "Nulmeting", goal: widget.goal),
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ]),
//     );
//   }
// }
