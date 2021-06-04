import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';

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
          BarChartRodData(y: 1, colors: [
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
                          color: Colors.white,
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
                    getTitles: (double value) {
                      // switch (value.toInt()) {
                      //   case 0:
                      //     return 'Mn';
                      //   case 1:
                      //     return 'Te';
                      //   case 2:
                      //     return 'Wd';
                      //   case 3:
                      //     return 'Tu';
                      //   case 4:
                      //     return 'Fr';
                      //   case 5:
                      //     return 'St';
                      //   case 6:
                      //     return 'Sn';
                      //   default:
                      //     return '';
                      // }

                      return activities[value.toInt()].dayFormat();
                    },
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
