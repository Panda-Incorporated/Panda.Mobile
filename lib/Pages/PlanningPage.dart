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
