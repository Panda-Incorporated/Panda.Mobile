// // import 'dart:math';
// //
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:panda/Models/models.dart';
// //
// // class LineChartSample1 extends StatefulWidget {
// //   final Goal goal;
// //
// //   const LineChartSample1({Key key, this.goal}) : super(key: key);
// //   @override
// //   State<StatefulWidget> createState() => LineChartSample1State();
// // }
// //
// // class LineChartSample1State extends State<LineChartSample1> {
// //   bool isShowingMainData;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     isShowingMainData = true;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AspectRatio(
// //       aspectRatio: 1.23,
// //       child: Container(
// //         decoration: const BoxDecoration(
// //           borderRadius: BorderRadius.all(Radius.circular(18)),
// //           gradient: LinearGradient(
// //             colors: [
// //               Color(0xff2c274c),
// //               Color(0xff46426c),
// //             ],
// //             begin: Alignment.bottomCenter,
// //             end: Alignment.topCenter,
// //           ),
// //         ),
// //         child: Stack(
// //           children: <Widget>[
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: <Widget>[
// //                 const SizedBox(
// //                   height: 37,
// //                 ),
// //                 Expanded(
// //                   child: Padding(
// //                     padding: const EdgeInsets.only(right: 16.0, left: 6.0),
// //                     child: LineChart(
// //
// //                       isShowingMainData ? sampleData1() : sampleData2(),
// //                       swapAnimationDuration: const Duration(milliseconds: 250),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 10,
// //                 ),
// //               ],
// //             ),
// //             IconButton(
// //               icon: Icon(
// //                 Icons.refresh,
// //                 color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
// //               ),
// //               onPressed: () {
// //                 setState(() {
// //                   isShowingMainData = !isShowingMainData;
// //                 });
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   LineChartData sampleData1() {
// //     return LineChartData(
// //       lineTouchData: LineTouchData(
// //         enabled: false,
// //       ),
// //       titlesData: FlTitlesData(
// //         bottomTitles: SideTitles(
// //           interval: 2,
// //           showTitles: true,
// //           reservedSize: 22,
// //           getTextStyles: (value) => const TextStyle(
// //             color: Color(0xff72719b),
// //             fontWeight: FontWeight.bold,
// //             fontSize: 16,
// //           ),
// //           // afstand X as met lijntjes
// //           margin: 10,
// //         ),
// //         leftTitles: SideTitles(
// //           interval: 5,
// //           showTitles: true,
// //           getTextStyles: (value) => const TextStyle(
// //             color: Color(0xff75729e),
// //             fontWeight: FontWeight.bold,
// //             fontSize: 17,
// //           ),
// //           reservedSize: 30,
// //         ),
// //       ),
// //       borderData: FlBorderData(
// //         show: true,
// //         border: Border.all(color: Color(0xff4e4965)),
// //       ),
// //       // minX altijd 0
// //       minX: 0,
// //       //maxX altijd duur training
// //       maxX:
// //           widget.goal.endday.difference(widget.goal.beginday).inDays.toDouble(),
// //       // max y = nulmeting begin + 20
// //       maxY: (widget.goal.getMesurement() + 20).toDouble(),
// //       //minY altijd doel -20
// //       minY: (widget.goal.goal - 20).toDouble(),
// //       lineBarsData: linesBarData1(widget.goal),
// //     );
// //   }
// //
// //   List<LineChartBarData> linesBarData1(Goal goal) {
// //     return [
// //       //  drawLine(Color(0xff4af699), goal, generateActivitySpots(goal)),
// //       drawLine(
// //           Color(0xffaa4cfc),
// //           goal,
// //           generateSpots(goal.getMesurement(), goal.goal,
// //               goal.endday.difference(goal.beginday).inDays)),
// //       //  drawLine(Color(0xff27b6fc), goal, generatePredictLine(goal)),
// //     ];
// //   }
// //
// //   List<LineChartBarData> linesBarData2(Goal goal) {
// //     return [
// //       drawLine(Color(0xff4af699), goal, generateActivitySpots(goal)),
// //       drawLine(
// //           Color(0xffaa4cfc),
// //           goal,
// //           generateSpots(goal.getMesurement(), goal.goal,
// //               goal.endday.difference(goal.beginday).inDays)),
// //       //  drawLine(Color(0xff27b6fc), goal, generatePredictLine(goal)),
// //     ];
// //   }
// //
// // // genereert voltooide activiteiten lijn
// //   List<FlSpot> generateActivitySpots(Goal goal) {
// //     List<FlSpot> list = [];
// //     for (var i = 0; i < goal.doneActivity.length; i++) {
// //       var y = goal.doneActivity[i].getSecondsPerKilometer();
// //       list.add(FlSpot(
// //           goal.doneActivity[i].getDaysFromStartDay(goal.beginday).toDouble(),
// //           y.toDouble()));
// //     }
// //
// //     return list;
// //   }
// //
// //   LineChartBarData drawLine(Color color, Goal goal, List<FlSpot> spots) {
// //     return LineChartBarData(
// //       spots: spots,
// //       isCurved: false,
// //       colors: [color],
// //       barWidth: 2,
// //       // display dots uit
// //       dotData: FlDotData(
// //         show: false,
// //       ),
// //       //display alles onder de lijn false
// //       belowBarData: BarAreaData(
// //         show: false,
// //       ),
// //     );
// //   }
// //
// //   // genereert ideale lijnen TODO: single goal
// //   List<FlSpot> generateSpots(int begin, int goal, int days) {
// //     List<FlSpot> list = [];
// //     for (var i = 0; i < days + 1; i++) {
// //       var y = (goal - begin) / sqrt(days) * sqrt(i) + begin;
// //       list.add(FlSpot(i.toDouble(), y));
// //     }
// //
// //     return list;
// //   }
// //
// //   LineChartData sampleData2() {
// //     return LineChartData(
// //       lineTouchData: LineTouchData(
// //         enabled: false,
// //       ),
// //       titlesData: FlTitlesData(
// //         bottomTitles: SideTitles(
// //           interval: 2,
// //           showTitles: true,
// //           reservedSize: 22,
// //           getTextStyles: (value) => const TextStyle(
// //             color: Color(0xff72719b),
// //             fontWeight: FontWeight.bold,
// //             fontSize: 16,
// //           ),
// //           // afstand X as met lijntjes
// //           margin: 10,
// //         ),
// //         leftTitles: SideTitles(
// //           interval: 5,
// //           showTitles: true,
// //           getTextStyles: (value) => const TextStyle(
// //             color: Color(0xff75729e),
// //             fontWeight: FontWeight.bold,
// //             fontSize: 17,
// //           ),
// //           reservedSize: 30,
// //         ),
// //       ),
// //       borderData: FlBorderData(
// //         show: true,
// //         border: Border.all(color: Color(0xff4e4965)),
// //       ),
// //       // minX altijd 0
// //       minX: 0,
// //       //maxX altijd duur training
// //       maxX:
// //           widget.goal.endday.difference(widget.goal.beginday).inDays.toDouble(),
// //       // max y = nulmeting begin + 20
// //       maxY: (widget.goal.getMesurement() + 20).toDouble(),
// //       //minY altijd doel -20
// //       minY: (widget.goal.goal - 20).toDouble(),
// //       lineBarsData: linesBarData2(widget.goal),
// //     );
// //   }
// // }
//
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
//
// class PieChartSample2 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }
//
// class PieChart2State extends State {
//   int touchedIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Card(
//         color: Colors.white,
//         child: Row(
//           children: <Widget>[
//             const SizedBox(
//               height: 18,
//             ),
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: PieChart(
//                   PieChartData(
//                       pieTouchData:
//                           PieTouchData(touchCallback: (pieTouchResponse) {
//                         setState(() {
//                           final desiredTouch = pieTouchResponse.touchInput
//                                   is! PointerExitEvent &&
//                               pieTouchResponse.touchInput is! PointerUpEvent;
//                           if (desiredTouch &&
//                               pieTouchResponse.touchedSection != null) {
//                             touchedIndex = pieTouchResponse
//                                 .touchedSection!.touchedSectionIndex;
//                           } else {
//                             touchedIndex = -1;
//                           }
//                         });
//                       }),
//                       borderData: FlBorderData(
//                         show: false,
//                       ),
//                       sectionsSpace: 0,
//                       centerSpaceRadius: 40,
//                       sections: showingSections()),
//                 ),
//               ),
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const <Widget>[
//                 Indicator(
//                   color: Color(0xff0293ee),
//                   text: 'First',
//                   isSquare: true,
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Indicator(
//                   color: Color(0xfff8b250),
//                   text: 'Second',
//                   isSquare: true,
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Indicator(
//                   color: Color(0xff845bef),
//                   text: 'Third',
//                   isSquare: true,
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Indicator(
//                   color: Color(0xff13d38e),
//                   text: 'Fourth',
//                   isSquare: true,
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 28,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: const Color(0xff13d38e),
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }
