import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Colors.green[700], width: 6.0),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Center(
                    child: Text(
                      "75%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w400,
                      ),
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
                            child: LineChart(sampleData1()),
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

  LineChartData sampleData1() {
    return LineChartData(
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
      maxX: 10,
      // max y = nulmeting begin + 20
      maxY: 500,
      //minY altijd doel -20
      minY: 440,
      lineBarsData: linesBarData1(),
    );
  }

  List<FlSpot> spotsL1 = <FlSpot>[
    FlSpot(0, 480),
    FlSpot(7, 470),
    FlSpot(10, 460),
  ];
  List<FlSpot> spotsL2 = <FlSpot>[
    FlSpot(0, 480),
    FlSpot(3, 478),
    FlSpot(10, 475),
  ];
  List<FlSpot> spotsL3 = <FlSpot>[
    FlSpot(0, 480),
    FlSpot(3, 460),
    FlSpot(10, 450)
  ];

  Color colorL1 = Color(0xff4af699);
  Color colorL2 = Color(0xffaa4cfc);
  Color colorL3 = Color(0xff27b6fc);

  LineChartBarData lines(List<FlSpot> spots, Color color) {
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

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData ln1 = lines(spotsL1, colorL1);
    final LineChartBarData ln2 = lines(spotsL2, colorL2);
    final LineChartBarData ln3 = lines(spotsL3, colorL3);
    return [
      ln1,
      ln2,
      ln3,
    ];
  }
}
