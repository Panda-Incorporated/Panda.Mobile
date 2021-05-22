import 'package:flutter/material.dart';

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({Key key}) : super(key: key);

  @override
  _TrainingsPageState createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Test text"),
    ));
  }
}
