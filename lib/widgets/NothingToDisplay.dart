import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';

class NothingToDisplay extends StatelessWidget {
  final String message;

  const NothingToDisplay({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(Glyphicon.question),
          Text(message ?? "Niks om weer te geven")
        ],
      ),
    );
  }
}
