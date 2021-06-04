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

  Future<List<BarChartGroupData>> loadInBarItems(Goal goal) async {
    activities = await goal.activities();
    activities.sort((a, b) => a.date.compareTo(b.date));
    activities.where((f) => f.distance > 5000).toList(); //filter with treshold
    List<BarChartGroupData> returnlist = [];
    for (int i = 0; i < activities.length; i++) {
      var value = BarChartGroupData(
        x: i,
        barRods: [
          //y moet km per distance worden
          BarChartRodData(y: 5, colors: [
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
    var temp = await widget.goal.activities();
    if (widget.goal != null && temp.length > 0 && widget.goal.goal > 0) {
      barItems = await loadInBarItems(widget.goal);
      activities = temp;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            body: BarChart(
              BarChartData(
                maxY: 20,
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
                        int rodIndex,) {
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
                    margin: 10,
                    getTitles: (double value) =>
                        activities[value.toInt()].date.ToInput('01-01'),
                  ),
                  leftTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: barItems,
              ),
            ),
          );
  }
}
