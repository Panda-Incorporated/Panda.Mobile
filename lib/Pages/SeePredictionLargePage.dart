import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SeePredictionLargePage extends StatefulWidget {
  const SeePredictionLargePage({Key key}) : super(key: key);

  @override
  _SeePredictionLargePageState createState() => _SeePredictionLargePageState();
}

class _SeePredictionLargePageState extends State<SeePredictionLargePage> {
  bool isShowingMainData;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 6.0,
                    backgroundColor: Colors.green[100],
                    percent: 0.7,
                    progressColor: Colors.green[800],
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    center: Text(
                      "70%",
                      style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "{Naam doel}",
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              alignment: Alignment.centerLeft,
              child: Text("Voorspelling"),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2c274c),
                      Color(0xff46426c),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 6.0),
                            child: LineChart(
                                sampleData1(begin: 580, goal: 520, weeks: 10)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1({begin, goal, weeks}) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          interval: 2,
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          // afstand X as met lijntejs
          margin: 10,
        ),
        leftTitles: SideTitles(
          interval: 5,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Color(0xff4e4965)),
      ),
      // minX altijd 0
      minX: 0,
      //maxX altijd duur training
      maxX: weeks,
      // max y = nulmeting begin + 20
      maxY: begin + 20,
      //minY altijd doel -20
      minY: goal - 20,
      lineBarsData: linesBarData1(begin, goal, weeks),
    );
  }

  LineChartBarData lines(Color color, int begin, int goal, int weeks) {
    return LineChartBarData(
      spots: generateSpots(begin, goal, weeks),
      isCurved: false,
      colors: [color],
      barWidth: 2,
      // display dots uit
      dotData: FlDotData(
        show: false,
      ),
      //display alles onder de lijn false
      belowBarData: BarAreaData(
        show: false,
      ),
    );
  }

  List<LineChartBarData> linesBarData1(int begin, int goal, int weeks) {
    return [
      lines(Color(0xff4af699), begin, goal, weeks),
      lines(Color(0xffaa4cfc), begin, goal, weeks),
      lines(Color(0xff27b6fc), begin, goal, weeks),
    ];
  }
}

List<FlSpot> generateSpots(int begin, int goal, int weeks) {
  List<FlSpot> list = [];
  for (var i = 0; i < weeks; i++) {
    var y = (goal - begin) / sqrt(weeks) * sqrt(i) + begin;
    list.add(FlSpot(i.toDouble(), y));
  }

  return list;
}
