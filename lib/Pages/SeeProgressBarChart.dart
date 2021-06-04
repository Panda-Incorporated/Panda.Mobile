import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartPage extends StatefulWidget {
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          //

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
                switch (value.toInt()) {
                  case 0:
                    return 'Mn';
                  case 1:
                    return 'Te';
                  case 2:
                    return 'Wd';
                  case 3:
                    return 'Tu';
                  case 4:
                    return 'Fr';
                  case 5:
                    return 'St';
                  case 6:
                    return 'Sn';
                  default:
                    return '';
                }
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                //y moet km per distance worden
                BarChartRodData(y: 8, colors: [
                  Theme.of(context).primaryColor,
                  Colors.lightBlueAccent,
                ])
              ],
              showingTooltipIndicators: [0],
            ),
          ],
        ),
      ),
    );
  }
}
