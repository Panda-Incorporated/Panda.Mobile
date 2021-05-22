import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
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
  double percentage = 0.0;
  List<LineChartBarData> barData = List.empty();
  int measurement = 0;
  List<Activity> activities;
  double big = 0.0;
  double small = 6.0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    percentage = await widget.goal.getPercentage();
    barData = await generateLines(widget.goal);
    measurement = await widget.goal.getMeasurement();
    activities = await widget.goal.activities();
    for (int i = 0; i < activities.length; i++) {
      if (activities[i].RichelFormula(widget.goal.distance) > big)
        big = activities[i].RichelFormula(widget.goal.distance);
    }
    for (int j = 0; j < activities.length; j++) {
      if (small < activities[j].RichelFormula(widget.goal.distance))
        small = activities[j].RichelFormula(widget.goal.distance).toDouble();
    }
    if (widget.goal.goal < small) {
      small = widget.goal.goal.toDouble();
    }
    print(small);
    print(big);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if ((percentage * 100) >= 100)
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
                      percent: percentage,
                      progressColor: Colors.green[800],
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      center: Text(
                        "${(percentage * 100).toStringAsFixed(1)}%",
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
            //TODO: 'mappen' naar dichstbijzijnd getal voor de steps Y as formule staat er al
            // moet nog omzetten naar [10,15,20,25]
            //((big - small) / 21).toInt().toDouble()
            interval: 20,
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
        maxY: big.toDouble() + 11,
        //minY altijd doel -20
        minY: small.toDouble() - 9,
        lineBarsData: barData,
      ),
    );
  }

  LineChartBarData drawLine(Color color, List<FlSpot> spots) {
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

  Future<List<LineChartBarData>> generateLines(Goal goal) async {
    return [
      drawLine(Color(0xff4af699), await generateActivitySpots(goal)),
      drawLine(Color(0xffaa4cfc), await generateSpots(goal)),
      drawLine(Color(0xff27b6fc), await generatePredictLine(goal)),
    ];
  }
}

Future<List<FlSpot>> generateSpots(Goal goal) async {
  var days = goal.endday.difference(goal.beginday).inDays;

  List<FlSpot> list = [];
  for (var i = 0; i < days + 1; i++) {
    var y = (goal.goal - await goal.getMeasurement()) / sqrt(days) * sqrt(i) +
        await goal.getMeasurement();
    list.add(FlSpot(i.toDouble(), y));
  }
  return list;
}

// genereert voltooide activiteiten lijn
Future<List<FlSpot>> generateActivitySpots(Goal goal) async {
  List<FlSpot> list = [];
  var activities = await goal.activities();
  for (var i = 0; i < activities.length; i++) {
    var y = activities[i].RichelFormula(goal.distance);
    list.add(FlSpot(activities[i].getDaysFromStartDay(goal.beginday).toDouble(),
        y.toDouble()));
  }

  return list;
}

Future<List<FlSpot>> generatePredictLine(Goal goal) async {
  var activities = await goal.activities();

  activities.sort((a, b) => a.date.compareTo(b.date));
  Activity lastactivity = activities.last;

  double y = lastactivity.RichelFormula(goal.distance);
  double beginpunt = lastactivity.getDaysFromStartDay(goal.beginday).toDouble();

  double kmsPredicted = await goal.getNextPoint();
  Activity secondlastactivity = activities[activities.length - 2];
  double diffrencedays =
      lastactivity.date.difference(secondlastactivity.date).inDays.toDouble();
  List<FlSpot> list = [];
  print("diffrence $diffrencedays");
  print("$kmsPredicted");
  list.add(FlSpot(beginpunt, y));
  list.add(FlSpot(beginpunt + diffrencedays, kmsPredicted));

  return list;
}

Widget legenda(Color color, String name) {
  return Container(
    padding: const EdgeInsets.all(6.0),
    height: 30,
    width: 130,
    color: Colors.grey[200],
    child: Row(
      children: [
        Container(
          color: color,
          height: 10,
          width: 40,
        ),
        SizedBox(width: 5),
        Container(
          child: Text(
            name + " lijn",
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    ),
  );
}
