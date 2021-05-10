import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panda/widgets/Logo.dart';

import '../data/pie_data.dart';
import '../widgets/pie_chart_sections.dart';

class Fitbitselection extends StatefulWidget {
  @override
  _FitbitselectionState createState() => _FitbitselectionState();
}

class _FitbitselectionState extends State<Fitbitselection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            stretchTriggerOffset: 200,
            floating: true,
            bottom: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Kies uit Fitbit activiteiten",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.zoomBackground],
              collapseMode: CollapseMode.pin,
              background: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Logo(),
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 300,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => print("Hallo"), //werkt
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // helemaal links helemaal rechts
                              children: [
                                Column(
                                  //tekst datum en doel moeten onder elkaar
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 0),
                                          child: Text(
                                            "Titel",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 0),
                                          child: Text(
                                            "subtitle",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // de check
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 10.0, vertical: 0),
                                //     width: 60,
                                //     height: 60,
                                //     decoration: BoxDecoration(
                                //         color: Theme.of(context).primaryColor,
                                //         border: Border.all(
                                //             color: Colors.green, width: 6.0),
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(100))),
                                //     child: Center(
                                //       child: Text(
                                //         "percentage",
                                //         //widget.percentage.toString() + "%",
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontSize: 14,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                          width: 80,
                                          height: 80,
                                          child: PieChart(
                                            PieChartData(
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 30,

                                              // startDegreeOffset: 0,
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sections: getSections(),
                                            ),
                                          )),
                                      Text(
                                        "${PieData.data[1].percent}%",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
