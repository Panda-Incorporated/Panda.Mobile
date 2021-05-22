// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:panda/Models/Activity.dart';
// import 'package:panda/Models/Goal.dart';
// import 'package:panda/main.dart';
// import 'package:panda/widgets/Logo.dart';
//
// import 'Home.dart';
//
// class GiveStarPage extends StatefulWidget {
//   final Goal goal;
//   final Activity activity;
//
//   const GiveStarPage({Key key, @required this.goal, @required this.activity})
//       : super(key: key);
//
//   @override
//   _GiveStarPageState createState() => _GiveStarPageState();
// }
//
// class _GiveStarPageState extends State<GiveStarPage> {
//   int measurement = 0;
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     measurement = await widget.goal.getMeasurement();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var multiplier = [1.2, 1.0, 0.8];
//     var kmsdif = [-4, 0, 4];
//     var days = widget.goal.endday.difference(widget.goal.beginday).inDays;
//     var i = DateTime.now().difference(widget.goal.beginday).inDays;
//     var secPkm =
//         (widget.goal.goal - measurement) / sqrt(days) * sqrt(i) + measurement;
//
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
//                   Litem(
//                       text:
//                           "Loop ${((widget.goal.duration.inMinutes * multiplier[0]) / 2).ceilToDouble()} minuten hard",
//                       activity: widget.activity,
//                       goal: widget.goal,
//                       titel: "Duurloop"),
//                   Litem(
//                       text:
//                           "Loop ${(((widget.goal.distance / 1000) * multiplier[1]) / 2)} kilometer hard",
//                       activity: widget.activity,
//                       goal: widget.goal,
//                       titel: "Langloop"),
//                   Litem(
//                       text:
//                           "Loop gemiddeld ${secPkm.ceilToDouble() + kmsdif[1]} sec/km over 3km",
//                       activity: widget.activity,
//                       goal: widget.goal,
//                       titel: "Snelheidsloop"),
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ]),
//     );
//   }
// }
//
// class Litem extends StatelessWidget {
//   final String text;
//   final Activity activity;
//   final Goal goal;
//   final String titel;
//
//   const Litem(
//       {Key key,
//       @required this.text,
//       @required this.activity,
//       @required this.goal,
//       @required this.titel})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var multiplier = [1.2, 1.0, 0.8];
//     var kmsdif = [-4, 0, 4];
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: GestureDetector(
//         onTap: () => {
//           print(amountOfStarsMPSEC(
//               activity.getSecondsPerKilometer(), kmsdif, goal.goal)),
//           print(amountOfStarsDistance(
//               //tod: activity.meters
//               1000,
//               multiplier,
//               goal.distance)),
//           //TOD activity.totalactivitytime.inMinutes
//           print(amountOfStarsTime(6, multiplier, goal.duration.inMinutes)),
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => Navigation()))
//         },
//         // {
//         //   Navigator.push(
//         //     context,
//         //     MaterialPageRoute(builder: (context) => Home()),
//         //     //TO (REINDERT) sterren toevoegen aan persoon sterrren krijg je door functie uit te voeren onder aan de pagina of boven beschreven
//         //
//         //   )
//         // },
//         child: Container(
//           decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               border: Border.all(color: Colors.white24),
//               borderRadius: BorderRadius.all(Radius.circular(6))),
//
//           // kleur knop
//           child: Container(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   // helemaal links helemaal rechts
//                   children: [
//                     Column(
//                       //tekst datum en doel moeten onder elkaar
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 10.0, vertical: 0),
//                               child: Text(
//                                 "$titel",
//                                 style: TextStyle(
//                                     fontSize: 30, fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 10.0, vertical: 0),
//                               child: Text(
//                                 "$text",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.w500),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
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
