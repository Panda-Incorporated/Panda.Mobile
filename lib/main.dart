import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panda/widgets/pie_chart_sections.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final lightBlue = const Color(0xFFEBFAFF);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image(
              height: 400,
              image: AssetImage('assets/panda.png'),
            ),
          ),
          Container(
            width: 450,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Welkom {Insert Name here}",
                      style: TextStyle(
                        fontSize: 34,

                        // fontFamily: "lettertype",
                        // color: Colors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    // margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lopende doelen:",
                      style: TextStyle(
                        fontSize: 26,
                        // fontFamily: "lettertype",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    // als er op het blauwe wordt geklikt
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 150,
                      width: 400,
                      color: lightBlue,
                      // kleur knop
                      child: Column(
                        // je hebt de bovenste en (divider)en onderste laag
                        children: [
                          Row(
                            // naam en doel moeten van links naar rechts
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // helemaal links helemaal rechts
                            children: [
                              Container(
                                // linkerdeel
                                child: Column(
                                  // 2 zinnen onderelkaar
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Marathon",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "25 km in 2,5 uur",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                //2de deel van de row
                                child: Text(
                                  "75%",
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            indent: 14,
                            endIndent: 14,
                            height: 10,
                            // zwarte lijn dat nog in de main column zit
                            color: Colors.green,
                          ),
                          Container(
                            child: Column(
                              //tekst datum en doel moeten onder elkaar
                              children: [
                                // Column(
                                //   children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Morgen 7 april",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 50),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "5km in 30 minuten",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Afgeronde doelen:",
                      style: TextStyle(
                        fontSize: 26,
                        // fontFamily: "lettertype",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      color: lightBlue,
                      // kleur knop
                      height: 100,
                      width: 400,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // helemaal links helemaal rechts
                          children: [
                            Column(
                              //tekst datum en doel moeten onder elkaar
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Marathon",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "5km in 30 minuten",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // hier zou dan de check moeten komen
                            Container(
                                width: 80,
                                height: 80,
                                child: PieChart(
                                  PieChartData(
                                    borderData: FlBorderData(show: false),
                                    sections: getSections(),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
