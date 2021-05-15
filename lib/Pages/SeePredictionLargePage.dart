import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SeePredictionLargePage extends StatefulWidget {
  final Goal goal;

  const SeePredictionLargePage({Key key, @required this.goal})
      : super(key: key);

  @override
  _SeePredictionLargePageState createState() => _SeePredictionLargePageState();
}

class _SeePredictionLargePageState extends State<SeePredictionLargePage> {
  bool isShowingMainData;

  @override
  @override
  Widget build(BuildContext context) {
    if (widget.goal.getSecondsPerKilometer() < widget.goal.secondsperkilometer)
      return Text(
          "goal al bereikt"); // placeholder om een glitchende grafiek tegen te gaan
    else
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: const EdgeInsets.all(16.0),
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
                      percent: widget.goal.getPercentage() / 100,
                      progressColor: Colors.green[800],
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      center: Text(
                        "${widget.goal.getPercentage()}",
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
                      "${widget.goal.title}",
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey[200],
                        Colors.grey[200],
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
                              child: LineChart(displayData(
                                  begin: widget.goal.getSecondsPerKilometer(),
                                  goal: widget.goal.secondsperkilometer,
                                  days: widget.goal.endday
                                      .difference(widget.goal.beginday)
                                      .inDays)),
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

  // main functie data weergeven (//TODO: kan vervangen worden door goal)
  LineChartData displayData({int begin, int goal, int days}) {
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
      maxX: days.toDouble(),
      // max y = nulmeting begin + 20
      maxY: (begin + 20).toDouble(),
      //minY altijd doel -20
      minY: (goal - 20).toDouble(),
      //TODO: kan nog vervangen worden door single goal (days is present-future)
      lineBarsData: generateLines(
          begin, goal, days, widget.goal, widget.goal.doneActivity),
    );
  }

  LineChartBarData goalline(Color color, Goal goal) {
    return LineChartBarData(
      spots: generateSpots(
          goal.getSecondsPerKilometer(),
          goal.secondsperkilometer,
          widget.goal.endday.difference(widget.goal.beginday).inDays),
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

  LineChartBarData activityline(Color color, Goal goal) {
    return LineChartBarData(
      spots: generateActivitySpots(goal),
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

  //TODO: hier een predictielijn van maken met single goal
  LineChartBarData lines(Color color, int begin, int goal, int days) {
    return LineChartBarData(
      spots: generateSpots(begin, goal, days),
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

  //genereerd alle 3 de lijnen TODO: single goal
  List<LineChartBarData> generateLines(
      int begin, int goal, int days, Goal goal2, List<Activity> activity) {
    return [
      activityline(Color(0xff4af699), goal2),
      goalline(Color(0xffaa4cfc), goal2),
      lines(Color(0xff27b6fc), begin - 10, goal, days),
    ];
  }
}

// genereert ideale lijnen TODO: single goal
List<FlSpot> generateSpots(int begin, int goal, int days) {
  List<FlSpot> list = [];
  for (var i = 0; i < days + 1; i++) {
    var y = (goal - begin) / sqrt(days) * sqrt(i) + begin;
    list.add(FlSpot(i.toDouble(), y));
  }

  return list;
}

// genereert voltooide activiteiten lijn
List<FlSpot> generateActivitySpots(Goal goal) {
  List<FlSpot> list = [];
  for (var i = 0; i < goal.doneActivity.length; i++) {
    var y = goal.doneActivity[i].getSecondsPerKilometer();
    list.add(FlSpot(
        goal.doneActivity[i].getDaysFromStartDay(goal.beginday).toDouble(),
        y.toDouble()));
  }

  return list;
}
