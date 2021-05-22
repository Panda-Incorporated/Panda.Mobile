import 'package:flutter/material.dart';
import 'package:panda/Models/Goal.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ListItem extends StatefulWidget {
  ListItem({Key key, this.goal, this.onTap}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
  final Goal goal;
  final Function onTap;
}

class _ListItemState extends State<ListItem> {
  double percentage = 0.1;
  String title = "";
  String subtitle = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    percentage = await widget.goal.getPercentage();
    title = await widget.goal.title;
    subtitle = await widget.goal.getString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget
            .onTap, //navigeren naar goal summaary page en dan goal meegeven
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(6))),

          // kleur knop
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                subtitle,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            backgroundColor: Colors.white,
                            percent: percentage,
                            progressColor: Colors.green,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            center: Text(
                              "${(percentage * 100).toInt()}",
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
