// import "package:flutter/material.dart";
//
// class SeePredictionsmall extends StatefulWidget {
//   @override
//   _SeePredictionsmallState createState() => _SeePredictionsmallState();
// }
//
// //TOD: circel progressbar implmenteren door goal mee te geven (pagina komt er niet in?)
// class _SeePredictionsmallState extends State<SeePredictionsmall> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Column(
//         children: [
//           // om het een plek te geven. Kan ook misschien met margin
//           Container(
//             height: MediaQuery.of(context).size.height / 3,
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 30.0),
//                 child: Container(
//                   height: 180,
//                   width: 180,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       border: Border.all(color: Colors.green[700], width: 6.0),
//                       borderRadius: BorderRadius.all(Radius.circular(100))),
//                   child: Center(
//                     child: Text(
//                       "75%",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 36,
//                         color: Colors.green[700],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           //GoalSummary(goal: goal),
//           Padding(
//             padding: EdgeInsets.only(left: 15.0, top: 12.0, right: 15.0),
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 12.0, bottom: 10.0),
//                     child: Text(
//                       "Voorspelling",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.black,
//                     height: 200,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     // Voorspelling en voortgang
//   }
// }
