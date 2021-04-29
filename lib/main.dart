import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panda/Pages/Home.dart';
import 'package:panda/Pages/Fitbitselection.dart';

import 'Pages/fitbitselection2.dart';

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
      home: Home(),
    );
  }
}
