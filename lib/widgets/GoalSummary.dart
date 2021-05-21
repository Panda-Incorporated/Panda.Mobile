import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';

// class GoalSummary extends StatelessWidget {
//   final Goal goal;
//
//   const GoalSummary({Key key, this.goal}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           child: Text(
//             goal.title,
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         Icon(
//           Icons.outlined_flag,
//         ),
//         Text(
//             //TODO Future<double> to double
//             "${goal.activities().then((value) => value.last.distance)} km van ${goal.distance} km"),
//         Text(
//           "in",
//           style: TextStyle(fontSize: 12),
//         ),
//         Text("${goal.duration.inMinutes} minuten"),
//       ],
//     );
//   }
// }

class GoalSummary extends StatefulWidget {
  final Goal goal;

  const GoalSummary({Key key, this.goal}) : super(key: key);

  @override
  _GoalSummaryState createState() => _GoalSummaryState();
}

class _GoalSummaryState extends State<GoalSummary> {
  int time = 1;
  double percentage = 0.0;
  double distance1 = 19.0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    time = await widget.goal
        .activities()
        .then((value) => value.last.getSecondsPerKilometer());
    distance1 =
        await widget.goal.activities().then((value) => value.last.distance);
    percentage = await widget.goal.getPercentage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            widget.goal.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Icon(
          Icons.outlined_flag,
        ),
        Text(
            //TODO: fix percentage of afastand links volgens percentage rechts volgens afstand
            "${(widget.goal.distance * percentage).toInt()}   ${time * (widget.goal.distance / 1000)} over $distance1 km van ${widget.goal.distance} km"),
        Text(
          "in",
          style: TextStyle(fontSize: 12),
        ),
        Text("${widget.goal.duration.inMinutes} minuten"),
      ],
    );
  }
}
