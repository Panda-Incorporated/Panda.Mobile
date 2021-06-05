import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Utils/DateTimeExtension.dart';

class BarChartPage extends StatefulWidget {
  final Goal goal;

  const BarChartPage({Key key, @required this.goal}) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChartPage> {
  List<BarChartGroupData> barItems = [];

  List<Activity> activities;
  bool loading = false;

  List<String> generateYasNumbers() {
    double maxValue = calculateMaxY();

    List<String> yasNumbers = [];

    for (int i = 0; i < maxValue; i++) {
      yasNumbers.add(i.toString());
    }

    return yasNumbers;
  }

  double calculateMaxY() {
    double biggestKmPHour = 0;

    for (int i = 0; i < activities.length; i++) {
      var kmperhour =
          ((activities[i].distance / activities[i].duration.inSeconds) * 3.6)
              .roundToDouble();
      if (kmperhour > biggestKmPHour) {
        biggestKmPHour = kmperhour;
      }
    }
    var result = biggestKmPHour + (biggestKmPHour * 0.2);
    return result;
  }

  Future<List<BarChartGroupData>> loadInBarItems(Goal goal) async {
    activities = await goal.activities();
    activities.sort((a, b) => a.date.compareTo(b.date));
    activities
        .where((f) => f.distance > (goal.distance / 2))
        .toList(); //filter with treshold
    List<BarChartGroupData> returnlist = [];
    for (int i = 0; i < activities.length; i++) {
      var kmperhour =
          ((activities[i].distance / activities[i].duration.inSeconds) * 3.6)
              .roundToDouble();

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

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    if (widget.goal != null && widget.goal.goal > 0) {
      barItems = await loadInBarItems(widget.goal);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: BarChart(
                BarChartData(
                  maxY: calculateMaxY(),
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
                    ),
                    leftTitles: SideTitles(
                        margin: 25,
                        showTitles: true,
                        interval: 4,
                        getTitles: (value) =>
                            (generateYasNumbers()[value.toInt()]) + " km/u"),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: barItems,
                ),
              ),
            ),
    );
  }
}
