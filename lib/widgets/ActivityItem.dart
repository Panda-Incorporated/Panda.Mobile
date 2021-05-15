import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';

class ActivityItem extends StatefulWidget {
  final Activity activity;

  const ActivityItem({
    Key key,
    this.activity,
  }) : super(key: key);

  @override
  _ActivityItemState createState() => _ActivityItemState();
}

//TODO: Fix formatting units
class _ActivityItemState extends State<ActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                "Titel",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                "${widget.activity.date}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //right part of row

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Column(
                          children: [
                            Text(
                              "${widget.activity.meters} m",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${widget.activity.totalactivitytime} secondes",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
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