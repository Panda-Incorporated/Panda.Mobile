// import 'dart:math';
//
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:panda/Models/Activity.dart';
// import 'package:panda/Models/Goal.dart';
// import 'package:panda/Utils/DateTimeExtension.dart';
//
// class BarChartPage extends StatefulWidget {
//   final Goal goal;
//
//   const BarChartPage({Key key, @required this.goal}) : super(key: key);
//
//   @override
//   _BarChartState createState() => _BarChartState();
// }
//
// class _BarChartState extends State<BarChartPage> {
//   List<BarChartGroupData> barItems = [];
//   bool isShowingMainData;
//   double percentage = 0.0;
//   List<LineChartBarData> barData = List.empty();
//   double big = 10.0;
//   double small = 1.0;
//   double biggestKmPHour = 0;
//
//   List<Activity> activities;
//   bool loading = false;
//
//   double calculateMaxY() {
//     double biggestKmPHour = 0;
//
//     for (int i = 0; i < activities.length; i++) {
//       var kmperhour = activities[i].KMPerHour();
//       if (kmperhour > biggestKmPHour) {
//         biggestKmPHour = kmperhour;
//       }
//     }
//
//     var result = biggestKmPHour + (biggestKmPHour * 0.2);
//     return result;
//   }
//
//   Future<List<BarChartGroupData>> loadInBarItems(Goal goal) async {
//     activities = await goal.activities();
//     activities.sort((a, b) => a.date.compareTo(b.date));
//     activities
//         .where((f) => f.distance > (goal.distance / 2))
//         .toList(); //filter with treshold
//     List<BarChartGroupData> returnlist = [];
//     for (int i = 0; i < activities.length; i++) {
//       var kmperhour =
//           ((activities[i].distance / activities[i].duration.inSeconds) * 3.6)
//               .roundToDouble();
//
//       var value = BarChartGroupData(
//         x: i,
//         barRods: [
//           BarChartRodData(y: kmperhour, colors: [
//             Color(0XFF01436D),
//             Colors.lightBlueAccent,
//           ])
//         ],
//         showingTooltipIndicators: [0],
//       );
//       returnlist.add(value);
//     }
//
//     return returnlist;
//   }
//
//   @override
//   void initState() {
//     getData();
//     isShowingMainData = true;
//     super.initState();
//   }
//
//   getData() async {
//     setState(() {
//       loading = true;
//     });
//     isShowingMainData = true;
//     if (widget.goal != null && widget.goal.goal > 0) {
//       barItems = await loadInBarItems(widget.goal);
//     }
//
//     var temp = await widget.goal.activities();
//     if (widget.goal != null && temp.length > 0 && widget.goal.goal > 0) {
//       percentage = await widget.goal.getPercentage();
//       barData = await generateLines(widget.goal);
//       activities = await widget.goal.activities();
//       if (activities != null && activities.length > 0) {
//         for (int i = 0; i < activities.length; i++) {
//           if (activities[i].RichelFormula(widget.goal.distance) > big)
//             big = activities[i].RichelFormula(widget.goal.distance);
//           if (small < activities[i].RichelFormula(widget.goal.distance))
//             small =
//                 activities[i].RichelFormula(widget.goal.distance).toDouble();
//           var kmperhour = activities[i].KMPerHour();
//           if (kmperhour > biggestKmPHour) {
//             biggestKmPHour = kmperhour;
//           }
//         }
//
//         if (widget.goal.goal < small) {
//           small = widget.goal.goal.toDouble();
//         }
//       }
//       biggestKmPHour += biggestKmPHour * 0.2;
//     }
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: loading
//           ? CircularProgressIndicator()
//           : Padding(
//               padding: const EdgeInsets.all(20),
//               child: barchart(),
//             ),
//     );
//   }
//
//   Widget barchart() {
//     return Expanded(
//       child: Container(
//         color: Colors.grey[200],
//         child: Stack(
//           alignment: Alignment.centerLeft,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: RotationTransition(
//                 child: Text("KM/UUR =>"),
//                 alignment: Alignment.centerLeft,
//                 turns: new AlwaysStoppedAnimation(-90 / 360),
//               ),
//             ),
//             Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 BarGraph(),
//                 Text("Dagen =>"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget BarGraph() {
//     return BarChart(
//       BarChartData(
//         maxY: biggestKmPHour,
//         alignment: BarChartAlignment.spaceAround,
//         barTouchData: BarTouchData(
//           enabled: false,
//         ),
//         // touchTooltipData: BarTouchTooltipData(
//         //   tooltipBgColor: Colors.transparent,
//         //   tooltipPadding: const EdgeInsets.all(0),
//         //   tooltipMargin: 8,
//         //   getTooltipItem: (
//         //     BarChartGroupData group,
//         //     int groupIndex,
//         //     BarChartRodData rod,
//         //     int rodIndex,
//         //   ) {
//         //     return BarTooltipItem(
//         //       rod.y.round().toString(),
//         //       TextStyle(
//         //         color: Colors.black,
//         //         fontWeight: FontWeight.bold,
//         //       ),
//         //     );
//         //   },
//         // ),
//         //  ),
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: SideTitles(
//             showTitles: true,
//             getTextStyles: (value) => const TextStyle(
//                 color: Color(0xff7589a2),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14),
//             getTitles: (value) =>
//                 activities[value.toInt()].date.ToInput('01-01'),
//             margin: 0,
//             reservedSize: 40,
//           ),
//           leftTitles: SideTitles(
//             margin: 5,
//             showTitles: true,
//             interval: 4,
//             reservedSize: 40,
//             //getTitles: (value) => (generateYasNumbers()[value.toInt()]),
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//         ),
//         barGroups: barItems,
//       ),
//     );
//   }
//
//   // Widget build(BuildContext context) {
//   //   return AspectRatio(
//   //     aspectRatio: 1.23,
//   //     child: Container(
//   //       decoration: const BoxDecoration(
//   //         borderRadius: BorderRadius.all(Radius.circular(18)),
//   //         gradient: LinearGradient(
//   //           colors: [
//   //             Color(0xff2c274c),
//   //             Color(0xff46426c),
//   //           ],
//   //           begin: Alignment.bottomCenter,
//   //           end: Alignment.topCenter,
//   //         ),
//   //       ),
//   //       child: Stack(
//   //         children: <Widget>[
//   //           Column(
//   //             crossAxisAlignment: CrossAxisAlignment.stretch,
//   //             children: <Widget>[
//   //               const SizedBox(
//   //                 height: 37,
//   //               ),
//   //               const Text(
//   //                 'Unfold Shop 2018',
//   //                 style: TextStyle(
//   //                   color: Color(0xff827daa),
//   //                   fontSize: 16,
//   //                 ),
//   //                 textAlign: TextAlign.center,
//   //               ),
//   //               const SizedBox(
//   //                 height: 4,
//   //               ),
//   //               const Text(
//   //                 'Monthly Sales',
//   //                 style: TextStyle(
//   //                     color: Colors.white,
//   //                     fontSize: 32,
//   //                     fontWeight: FontWeight.bold,
//   //                     letterSpacing: 2),
//   //                 textAlign: TextAlign.center,
//   //               ),
//   //               const SizedBox(
//   //                 height: 37,
//   //               ),
//   //               Expanded(
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.only(right: 16.0, left: 6.0),
//   //                   child: LineChart(
//   //                     isShowingMainData ? chart() : sampleData2(),
//   //                     swapAnimationDuration: const Duration(milliseconds: 250),
//   //                   ),
//   //                 ),
//   //               ),
//   //               const SizedBox(
//   //                 height: 10,
//   //               ),
//   //             ],
//   //           ),
//   //           IconButton(
//   //             icon: Icon(
//   //               Icons.refresh,
//   //               color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
//   //             ),
//   //             onPressed: () {
//   //               setState(() {
//   //                 isShowingMainData = !isShowingMainData;
//   //               });
//   //             },
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget barchart() {
//     return BarChart(
//       BarChartData(
//         maxY: calculateMaxY(),
//         alignment: BarChartAlignment.spaceAround,
//         barTouchData: BarTouchData(
//           enabled: false,
//           touchTooltipData: BarTouchTooltipData(
//             tooltipBgColor: Colors.transparent,
//             tooltipPadding: const EdgeInsets.all(0),
//             tooltipMargin: 8,
//             getTooltipItem: (
//               BarChartGroupData group,
//               int groupIndex,
//               BarChartRodData rod,
//               int rodIndex,
//             ) {
//               return BarTooltipItem(
//                 rod.y.round().toString(),
//                 TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             },
//           ),
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: SideTitles(
//             showTitles: true,
//             getTextStyles: (value) => const TextStyle(
//                 color: Color(0xff7589a2),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14),
//             getTitles: (value) =>
//                 activities[value.toInt()].date.ToInput('01-01'),
//           ),
//           leftTitles: SideTitles(
//               margin: 25,
//               showTitles: true,
//               interval: 4,
//               getTitles: (value) =>
//                   (generateYasNumbers()[value.toInt()]) + " km/u"),
//         ),
//         borderData: FlBorderData(
//           show: false,
//         ),
//         barGroups: barItems,
//       ),
//     );
//   }
//
//   LineChartData chart() {
//     return LineChartData(
//       // lineTouchData: LineTouchData(enabled: false),
//       titlesData: FlTitlesData(
//         bottomTitles: SideTitles(
//           interval: widget.goal.getTotalDays() <= 12
//               ? 1
//               : (widget.goal.getTotalDays() / 12).roundToDouble(),
//           showTitles: true,
//           reservedSize: 40,
//           getTextStyles: (value) => const TextStyle(
//             color: Color(0xff72719b),
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//           // afstand X as met lijntjes
//           margin: 0,
//         ),
//         leftTitles: SideTitles(
//
//             // interval: steps > 0 ? steps.toDouble() : 10,
//             interval: ((big - small) / 18).ceilToDouble(),
//             showTitles: true,
//             getTextStyles: (value) => const TextStyle(
//                   color: Color(0xff75729e),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 17,
//                 ),
//             reservedSize: 60,
//             //afstand y numer tot grafiek
//             margin: 0),
//       ),
//       borderData: FlBorderData(
//         border: Border.all(color: Color(0xff4e4965)),
//       ),
//       // minX altijd 0
//       minX: 0,
//
//       //maxX altijd duur training (in dagen)
//       maxX:
//           widget.goal.endday.difference(widget.goal.beginday).inDays.toDouble(),
//       maxY: big.toDouble(),
//       // minY altijd doel -20
//       minY: small.toDouble(),
//       lineBarsData: barData,
//     );
//   }
//
//   List<LineChartBarData> linesBarData1() {
//     final lineChartBarData1 = LineChartBarData(
//       spots: [
//         FlSpot(1, 1),
//         FlSpot(3, 1.5),
//         FlSpot(5, 1.4),
//         FlSpot(7, 3.4),
//         FlSpot(10, 2),
//         FlSpot(12, 2.2),
//         FlSpot(13, 1.8),
//       ],
//       isCurved: true,
//       colors: [
//         const Color(0xff4af699),
//       ],
//       barWidth: 8,
//       isStrokeCapRound: true,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(
//         show: false,
//       ),
//     );
//     final lineChartBarData2 = LineChartBarData(
//       spots: [
//         FlSpot(1, 1),
//         FlSpot(3, 2.8),
//         FlSpot(7, 1.2),
//         FlSpot(10, 2.8),
//         FlSpot(12, 2.6),
//         FlSpot(13, 3.9),
//       ],
//       isCurved: true,
//       colors: [
//         const Color(0xffaa4cfc),
//       ],
//       barWidth: 8,
//       isStrokeCapRound: true,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(show: false, colors: [
//         const Color(0x00aa4cfc),
//       ]),
//     );
//     final lineChartBarData3 = LineChartBarData(
//       spots: [
//         FlSpot(1, 2.8),
//         FlSpot(3, 1.9),
//         FlSpot(6, 3),
//         FlSpot(10, 1.3),
//         FlSpot(13, 2.5),
//       ],
//       isCurved: true,
//       colors: const [
//         Color(0xff27b6fc),
//       ],
//       barWidth: 8,
//       isStrokeCapRound: true,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(
//         show: false,
//       ),
//     );
//     return [
//       lineChartBarData1,
//       lineChartBarData2,
//       lineChartBarData3,
//     ];
//   }
//
//   LineChartData sampleData2() {
//     return LineChartData(
//       lineTouchData: LineTouchData(
//         enabled: false,
//       ),
//       gridData: FlGridData(
//         show: false,
//       ),
//       titlesData: FlTitlesData(
//         bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 22,
//           getTextStyles: (value) => const TextStyle(
//             color: Color(0xff72719b),
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//           margin: 10,
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 2:
//                 return 'SEPT';
//               case 7:
//                 return 'OCT';
//               case 12:
//                 return 'DEC';
//             }
//             return '';
//           },
//         ),
//         leftTitles: SideTitles(
//           showTitles: true,
//           getTextStyles: (value) => const TextStyle(
//             color: Color(0xff75729e),
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 1:
//                 return '1m';
//               case 2:
//                 return '2m';
//               case 3:
//                 return '3m';
//               case 4:
//                 return '5m';
//               case 5:
//                 return '6m';
//             }
//             return '';
//           },
//           margin: 8,
//           reservedSize: 30,
//         ),
//       ),
//       borderData: FlBorderData(
//           show: true,
//           border: const Border(
//             bottom: BorderSide(
//               color: Color(0xff4e4965),
//               width: 4,
//             ),
//             left: BorderSide(
//               color: Colors.transparent,
//             ),
//             right: BorderSide(
//               color: Colors.transparent,
//             ),
//             top: BorderSide(
//               color: Colors.transparent,
//             ),
//           )),
//       minX: 0,
//       maxX: 14,
//       maxY: 6,
//       minY: 0,
//       lineBarsData: linesBarData2(),
//     );
//   }
//
//   List<LineChartBarData> linesBarData2() {
//     return [
//       LineChartBarData(
//         spots: [
//           FlSpot(1, 1),
//           FlSpot(3, 4),
//           FlSpot(5, 1.8),
//           FlSpot(7, 5),
//           FlSpot(10, 2),
//           FlSpot(12, 2.2),
//           FlSpot(13, 1.8),
//         ],
//         isCurved: true,
//         curveSmoothness: 0,
//         colors: const [
//           Color(0x444af699),
//         ],
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: false,
//         ),
//         belowBarData: BarAreaData(
//           show: false,
//         ),
//       ),
//       LineChartBarData(
//         spots: [
//           FlSpot(1, 1),
//           FlSpot(3, 2.8),
//           FlSpot(7, 1.2),
//           FlSpot(10, 2.8),
//           FlSpot(12, 2.6),
//           FlSpot(13, 3.9),
//         ],
//         isCurved: true,
//         colors: const [
//           Color(0x99aa4cfc),
//         ],
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: false,
//         ),
//         belowBarData: BarAreaData(show: true, colors: [
//           const Color(0x33aa4cfc),
//         ]),
//       ),
//       LineChartBarData(
//         spots: [
//           FlSpot(1, 3.8),
//           FlSpot(3, 1.9),
//           FlSpot(6, 5),
//           FlSpot(10, 3.3),
//           FlSpot(13, 4.5),
//         ],
//         isCurved: true,
//         curveSmoothness: 0,
//         colors: const [
//           Color(0x4427b6fc),
//         ],
//         barWidth: 2,
//         isStrokeCapRound: true,
//         dotData: FlDotData(show: true),
//         belowBarData: BarAreaData(
//           show: false,
//         ),
//       ),
//     ];
//   }
// }
//
// LineChartBarData drawLine(Color color, List<FlSpot> spots) {
//   return LineChartBarData(
//     spots: spots,
//     isCurved: false,
//     colors: [color],
//     barWidth: 2,
//     // display dots uit
//     dotData: FlDotData(
//       show: false,
//     ),
//
//     //display alles onder de lijn false
//     belowBarData: BarAreaData(
//       show: false,
//     ),
//   );
// }
//
// Future<List<LineChartBarData>> generateLines(Goal goal) async {
//   if (goal != null)
//     return [
//       drawLine(Colors.black, await generateSpots(goal)),
//       drawLine(
//           Colors.orange, await generateTreshold(goal, goal.distance * 0.10)),
//       drawLine(Colors.grey, await generatePredictLine(goal)),
//       drawLine(Color(0xff4af699),
//           await generateTreshold(goal, 6500)) //goal.distance *0.05
//     ];
//   return [];
// }
//
// Future<List<FlSpot>> generateSpots(Goal goal) async {
//   List<FlSpot> list = [];
//
//   if (goal != null && goal.goal > 0) {
//     var activities = await goal.activities();
//     var days = goal.endday.difference(goal.beginday).inDays;
//     print("goal is ${goal.goal}");
//     list.add(FlSpot(
//         activities.first.getDaysFromStartDay(goal.beginday).toDouble() - 1,
//         activities.first.RichelFormula(goal.distance)));
//     var mes = await goal.getMeasurement();
//     for (var i = 1; i < days + 1; i++) {
//       var y = (goal.goal - mes) / sqrt(days) * sqrt(i) + mes;
//       print("paarse lijn punt is $y met i $i");
//       list.add(FlSpot(i.toDouble(), y));
//     }
//     print("total days ${goal.getTotalDays()}");
//     return list;
//   } else
//     return list;
// }
//
// Future<List<FlSpot>> generateTreshold(Goal goal, treshold) async {
//   List<FlSpot> list = [];
//   var activities = await goal.activities();
//
//   list.add(FlSpot(
//       activities.first.getDaysFromStartDay(goal.beginday).toDouble() - 1,
//       activities.first.RichelFormula(goal.distance)));
//   for (var i = 1; i < activities.length; i++) {
//     if (activities[i].distance > treshold) {
//       // treshold 5% van de loop goal.distance * 0.05
//       var y = activities[i].RichelFormula(goal.distance);
//
//       print("act spot is ${pow(y, 0.95) - 2}");
//       list.add(FlSpot(
//           activities[i].getDaysFromStartDay(goal.beginday).toDouble(),
//           pow(y, 0.95) - 2 < goal.goal
//               ? goal.goal.toDouble()
//               : pow(y, 0.95) - 2));
//     }
//   }
//
//   return list;
// }
//
// Future<List<FlSpot>> generatePredictLine(Goal goal) async {
//   var activities = await goal.activities();
//   var perc = await goal.getPercentage();
//   List<FlSpot> list = [];
//   if (activities != null && activities.length > 1 && perc > 0.0) {
//     print("perc is $perc");
//     activities.sort((a, b) => a.date.compareTo(b.date));
//     Activity lastactivity = activities.last;
//
//     double y = lastactivity.RichelFormula(goal.distance);
//     double beginpunt =
//         lastactivity.getDaysFromStartDay(goal.beginday).toDouble();
//
//     double kmsPredicted = await goal.getNextPoint();
//     print("next point is $kmsPredicted");
//     Activity secondlastactivity = activities[activities.length - 2];
//     double diffrencedays =
//         lastactivity.date.difference(secondlastactivity.date).inDays.toDouble();
//
//     print("diffrence $diffrencedays");
//     var setmax = beginpunt + diffrencedays > goal.getTotalDays()
//         ? goal.getTotalDays() - 1
//         : beginpunt + diffrencedays;
//     list.add(FlSpot(beginpunt, pow(y, 0.95) - 2));
//     list.add(FlSpot(
//         setmax.toDouble(),
//         pow(kmsPredicted, 0.95) + 2 > goal.goal
//             ? goal.goal.toDouble()
//             : pow(kmsPredicted, 0.95) + 2));
//     print("diffrence $diffrencedays");
//     print("$kmsPredicted");
//
//     return list;
//   } else
//     return list;
// }
//
// Widget legenda(Color color, String name) {
//   return Container(
//     padding: const EdgeInsets.all(6.0),
//     height: 30,
//     width: 140,
//     color: Colors.grey[200],
//     child: Row(
//       children: [
//         Container(
//           color: color,
//           height: 10,
//           width: 40,
//         ),
//         SizedBox(width: 5),
//         Container(
//           child: Text(
//             name + " lijn",
//             style: TextStyle(fontSize: 10),
//           ),
//         ),
//       ],
//     ),
//   );
// }
