import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panda/Pages/Fitbitselection.dart';
import 'package:panda/Pages/GoalSummaryPage.dart';
import 'package:panda/Pages/Home.dart';
import 'package:panda/Pages/SeePredictionLargePage.dart';
import 'package:panda/Pages/fitbitselection2.dart';

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
  int _selectedIndex = 1;

  List<Widget> _widgetOptions = [
    Home(),
    Fitbitselection(),
    Fitbitselection2(),
    GoalSummaryPage(),
    SeePredictionLargePage(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Scherm 1",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Scherm 2",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Scherm 3",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Scherm 4",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Scherm 5",
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
