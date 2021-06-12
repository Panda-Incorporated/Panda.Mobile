import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Utils/DateTimeExtension.dart';
import 'package:panda/widgets/ShowGraph.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'ActivitySelectionPage.dart';

class SeePredictionLargePage extends StatefulWidget {
  final Goal goal;

  const SeePredictionLargePage({Key key, @required this.goal})
      : super(key: key);

  @override
  _SeePredictionLargePageState createState() => _SeePredictionLargePageState();
}

class _SeePredictionLargePageState extends State<SeePredictionLargePage> {
  List<BarChartGroupData> barItems = [];
  double percentage = 0.0;
  List<LineChartBarData> barData = List.empty();
  List<Activity> activities;
  double big = 10.0;
  bool isShowingMainData;
  double small = 1.0;
  bool loading = false;
  double biggestKmPHour = 0;
  double maxYbar = 0.0;
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<BarChartGroupData>> loadInBarItems(Goal goal) async {
    activities = await goal.activities();
    activities.sort((a, b) => a.date.compareTo(b.date));
    activities
        .where((f) => f.distance > (goal.distance / 2))
        .toList(); //filter with treshold
    List<BarChartGroupData> returnlist = [];
    for (int i = 0; i < activities.length; i++) {
      var kmperhour = activities[i].KMPerHour();

      var value = BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(y: kmperhour, colors: [
            Color(0XFF01436D),
            Colors.lightBlueAccent,
          ])
        ],
        showingTooltipIndicators: [0],
      );
      returnlist.add(value);
    }

    return returnlist;
  }

  getData() async {
    setState(() {
      loading = true;
    });
    isShowingMainData = true;
    if (widget.goal != null && widget.goal.goal > 0) {
      barItems = await loadInBarItems(widget.goal);
    }

    activities = await widget.goal.activities();
    if (widget.goal != null && activities.length > 0 && widget.goal.goal > 0) {
      percentage = await widget.goal.getPercentage();
      barData = await generateLines(widget.goal);
      if (activities != null && activities.length > 0) {
        for (int i = 0; i < activities.length; i++) {
          if (activities[i].RichelFormula(widget.goal.distance) > big)
            big = activities[i].RichelFormula(widget.goal.distance);
          if (small < activities[i].RichelFormula(widget.goal.distance))
            small =
                activities[i].RichelFormula(widget.goal.distance).toDouble();
          var kmperhour = activities[i].KMPerHour();
          if (kmperhour > maxYbar) {
            maxYbar = kmperhour;
          }
        }

        if (widget.goal.goal < small) {
          small = widget.goal.goal.toDouble();
        }
      }
      maxYbar += maxYbar * 0.2;
    }

    setState(() {
      loading = false;
    });
  }

  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: listview zetten vragen aan reindert
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                  toggle ? Glyphicon.bar_chart_line : Glyphicon.graph_down),
              onPressed: () {
                controller.animateToPage(
                  controller.page == 1 ? 0 : 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
                toggle = !toggle;
                setState(() {});
              }),
        ],
      ),
      backgroundColor: Colors.white,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : barData.length > 0
              ? Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 6.0,
                            backgroundColor: Colors.green[100],
                            percent: percentage >= 1.0
                                ? 1.0
                                : percentage < 0.0
                                    ? 0.0
                                    : percentage,
                            progressColor: Colors.green[800],
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            center: Text(
                              "${(percentage * 100).toInt()}%",
                              style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "${widget.goal.title}",
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: controller,
                          children: <Widget>[
                            BarGraph(),
                            if (activities.length > 1)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 8.0,
                                    top: 8.0),
                                child: Column(
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Container(
                                    //       padding:
                                    //           EdgeInsets.symmetric(vertical: 16),
                                    //       alignment: Alignment.centerLeft,
                                    //       child: Text("Voorspelling"),
                                    //     ),
                                    //   ],
                                    // ),

                                    Expanded(
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Stack(
                                              alignment: Alignment.centerLeft,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: RotationTransition(
                                                    child: Text("Sec/km =>"),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    turns:
                                                        new AlwaysStoppedAnimation(
                                                            -90 / 360),
                                                  ),
                                                ),
                                                Stack(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  children: [
                                                    chart(),
                                                    Text("Dagen =>"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                legenda(Colors.orange,
                                                    "Progressie"),
                                                legenda(Colors.black, "Doel"),
                                                legenda(
                                                    Colors.grey, "Predictie"),
                                                legenda(Color(0xff4af699),
                                                    "Nulmeting"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ]),
                    ),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FullPageButton(
                        buttonTitle: "Activiteit toevoegen",
                        onTap: ActivitySelectionPage(),
                        title:
                            "U heeft nog geen nulmeting toegevoegd aan het doel",
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget chart() {
    return LineChart(
      LineChartData(
        // lineTouchData: LineTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            interval: widget.goal.getTotalDays() <= 12
                ? 1
                : (widget.goal.getTotalDays() / 12).roundToDouble(),
            showTitles: true,
            reservedSize: 40,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff72719b),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            // afstand X as met lijntjes
            margin: 0,
          ),
          leftTitles: SideTitles(

              // interval: steps > 0 ? steps.toDouble() : 10,
              interval: ((big - small) / 18).ceilToDouble() > 0
                  ? ((big - small) / 18).ceilToDouble()
                  : 10,
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                    color: Color(0xff75729e),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
              reservedSize: 60,
              //afstand y numer tot grafiek
              margin: 0),
        ),
        borderData: FlBorderData(
          border: Border.all(color: Color(0xff4e4965)),
        ),
        // minX altijd 0
        minX: 0,

        //maxX altijd duur training (in dagen)
        maxX: widget.goal.endday
            .difference(widget.goal.beginday)
            .inDays
            .toDouble(),
        maxY: big.toDouble(),
        // minY altijd doel -20
        minY: small.toDouble(),
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
    if (goal != null)
      return [
        drawLine(Colors.black, await generateSpots(goal)),
        drawLine(
            Colors.orange, await generateTreshold(goal, goal.distance * 0.10)),
        drawLine(Colors.grey, await generatePredictLine(goal)),
        drawLine(Color(0xff4af699),
            await generateTreshold(goal, 6500)) //goal.distance *0.05
      ];
    return [];
  }

  Widget BarGraph() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: RotationTransition(
            child: Text("km/uur =>"),
            alignment: Alignment.centerLeft,
            turns: new AlwaysStoppedAnimation(-90 / 360),
          ),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BarChart(
              BarChartData(
                maxY: maxYbar,
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(0),
                    tooltipMargin: 8,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.y.round().toString(),
                        TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    getTitles: (value) =>
                        activities[value.toInt()].date.ToInput('01-01'),
                    margin: 0,
                    reservedSize: 40,
                  ),
                  leftTitles: SideTitles(
                    margin: 5,
                    showTitles: true,
                    interval: 4,
                    reservedSize: 40,
                    //getTitles: (value) => (generateYasNumbers()[value.toInt()]),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: barItems,
              ),
            ),
            Text("Dagen =>"),
          ],
        ),
      ],
    );
  }

  Future<List<FlSpot>> generateSpots(Goal goal) async {
    List<FlSpot> list = [];

    if (goal != null && goal.goal > 0) {
      var activities = await goal.activities();
      var days = goal.endday.difference(goal.beginday).inDays;
      print("goal is ${goal.goal}");
      list.add(FlSpot(
          activities.first.getDaysFromStartDay(goal.beginday).toDouble() - 1,
          activities.first.RichelFormula(goal.distance)));
      var mes = await goal.getMeasurement();
      for (var i = 1; i < days + 1; i++) {
        var y = (goal.goal - mes) / sqrt(days) * sqrt(i) + mes;
        print("paarse lijn punt is $y met i $i");
        list.add(FlSpot(i.toDouble(), y));
      }
      print("total days ${goal.getTotalDays()}");
      return list;
    } else
      return list;
  }

  Future<List<FlSpot>> generateTreshold(Goal goal, treshold) async {
    List<FlSpot> list = [];
    var activities = await goal.activities();

    list.add(FlSpot(
        activities.first.getDaysFromStartDay(goal.beginday).toDouble() - 1,
        activities.first.RichelFormula(goal.distance)));
    for (var i = 1; i < activities.length; i++) {
      if (activities[i].distance > treshold) {
        // treshold 5% van de loop goal.distance * 0.05
        var y = activities[i].RichelFormula(goal.distance);

        print("act spot is ${pow(y, 0.95) - 2}");
        list.add(FlSpot(
            activities[i].getDaysFromStartDay(goal.beginday).toDouble(),
            pow(y, 0.95) - 2 < goal.goal
                ? goal.goal.toDouble()
                : pow(y, 0.95) - 2));
      }
    }

    return list;
  }

  Future<List<FlSpot>> generatePredictLine(Goal goal) async {
    var activities = await goal.activities();
    var perc = await goal.getPercentage();
    List<FlSpot> list = [];
    if (activities != null && activities.length > 1 && perc > 0.0) {
      print("perc is $perc");
      activities.sort((a, b) => a.date.compareTo(b.date));
      Activity lastactivity = activities.last;

      double y = lastactivity.RichelFormula(goal.distance);
      double beginpunt =
          lastactivity.getDaysFromStartDay(goal.beginday).toDouble();

      double kmsPredicted = await goal.getNextPoint();
      print("next point is $kmsPredicted");
      Activity secondlastactivity = activities[activities.length - 2];
      double diffrencedays = lastactivity.date
          .difference(secondlastactivity.date)
          .inDays
          .toDouble();

      print("diffrence $diffrencedays");
      var setmax = beginpunt + diffrencedays > goal.getTotalDays()
          ? goal.getTotalDays() - 1
          : beginpunt + diffrencedays;
      list.add(FlSpot(beginpunt, pow(y, 0.95) - 2));
      list.add(FlSpot(
          setmax.toDouble(),
          pow(kmsPredicted, 0.95) + 2 > goal.goal
              ? goal.goal.toDouble()
              : pow(kmsPredicted, 0.95) + 2));
      print("diffrence $diffrencedays");
      print("$kmsPredicted");

      return list;
    } else
      return list;
  }

  Widget legenda(Color color, String name) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: 30,
      width: 140,
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
}
