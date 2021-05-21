import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';

class NothingToDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [Icon(Glyphicon.question), Text("Niks om weer te geven")],
      ),
    );
  }
}
