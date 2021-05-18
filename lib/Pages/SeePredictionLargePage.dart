import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  @override
  @override
  Widget build(BuildContext context) {
    if ((widget.goal.getPercentage() * 100) >= 100)
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
                      percent: widget.goal.getPercentage(),
                      progressColor: Colors.green[800],
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      center: Text(
                        "${widget.goal.getPercentage() * 100}",
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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.centerLeft,
                    child: Text("Voorspelling"),
                  ),
                ],
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
                    alignment: Alignment.topRight,
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
                              child: chart(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          legenda(Color(0xff4af699), "Gelopen"),
                          legenda(Color(0xffaa4cfc), "Goal"),
                          legenda(Color(0xff27b6fc), "Predictie")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget chart() {
    return LineChart(
      LineChartData(
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
            // afstand X as met lijntjes
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
        maxX: widget.goal.endday
            .difference(widget.goal.beginday)
            .inDays
            .toDouble(),
        // max y = nulmeting begin + 20
        maxY: (widget.goal.getMesurement() + 20).toDouble(),
        //minY altijd doel -20
        minY: (widget.goal.goal - 20).toDouble(),
        lineBarsData: generateLines(widget.goal),
      ),
    );
  }

  LineChartBarData drawLine(Color color, Goal goal, List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
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

  List<LineChartBarData> generateLines(Goal goal) {
    return [
      drawLine(Color(0xff4af699), goal, generateActivitySpots(goal)),
      drawLine(
          Color(0xffaa4cfc),
          goal,
          generateSpots(goal.getMesurement(), goal.goal,
              widget.goal.endday.difference(widget.goal.beginday).inDays)),
      drawLine(Color(0xff27b6fc), goal, generatePredictLine(goal)),
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

List<FlSpot> generatePredictLine(Goal goal) {
  goal.doneActivity.sort((a, b) => a.date.compareTo(b.date));
  Activity lastactivity = goal.doneActivity.last;
  int kmslastpoint = lastactivity.getSecondsPerKilometer();
  Activity secondlastactivity = goal.doneActivity[goal.doneActivity.length - 2];

  int kmsfirstpoint = secondlastactivity.getSecondsPerKilometer();

  double diffrencekms = (kmsfirstpoint - kmslastpoint).toDouble();

  double diffrencedays =
      lastactivity.date.difference(secondlastactivity.date).inDays.toDouble();
  double progressionperquantum = diffrencekms / diffrencedays;
  int y = lastactivity.getSecondsPerKilometer();
  double beginpunt = lastactivity.getDaysFromStartDay(goal.beginday).toDouble();

  int predictionday = 2;

  double kmsPredicted = kmslastpoint - progressionperquantum * diffrencedays;

  List<FlSpot> list = [];
  list.add(FlSpot(beginpunt, y.toDouble()));
  list.add(FlSpot(beginpunt + predictionday,
      kmsPredicted > goal.goal ? kmsPredicted : goal.goal));

  return list;
}

Widget legenda(Color color, String name) {
  return Container(
    padding: const EdgeInsets.all(2.0),
    height: 30,
    width: 110,
    color: Colors.grey[200],
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: color,
          height: 10,
          width: 40,
        ),
        SizedBox(width: 5),
        Container(
          alignment: Alignment.center,
          child: Text(
            name + " lijn",
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    ),
  );
}
