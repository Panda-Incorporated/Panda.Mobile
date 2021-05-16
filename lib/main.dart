import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:panda/Pages/GoalSelectionPage.dart';
import 'package:panda/Pages/Home.dart';
import 'package:panda/Pages/Settings.dart';
import 'Pages/NewGoal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panda',
      theme: ThemeData(
        primaryColor: Color(0xFFEBFAFF),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  bool buttonsShown = false;
  List<Widget> _widgetOptions = [
    Home(),
    SettingsPage(),
    // GoalSelectionPage(),
    // ActivitySelectionPage(),
    // SeePredictionsmall(),

    // NIET VERANDEREN desnoods comment onder aan de pagina
    // GoalSummaryPage(
    //   goal: GoalProvider.getGoals()[0],
    // ),
    // // NIET VERANDEREN desnoods comment onder aan de pagina
    // SeePredictionLargePage(
    //   goal: GoalProvider.getGoals()[0],
    //   doel: 500,
    // ),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Stack(children: [
            _widgetOptions.elementAt(_selectedIndex),
            if (buttonsShown)
              Positioned(
                bottom: 30,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: "GoalSelection",
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalSelectionPage()),
                            )
                          },
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            child: Icon(
                              Glyphicon.lightning_charge,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        FloatingActionButton(
                          heroTag: "GoalCreate",
                          onPressed: () => {},
                          child: Icon(
                            Glyphicon.flag,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              buttonsShown = !buttonsShown;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings",
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
      ),
    );
  }
}
