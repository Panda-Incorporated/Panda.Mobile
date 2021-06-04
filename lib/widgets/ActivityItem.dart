import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Utils/ValueParser.dart';

class ActivityItem extends StatefulWidget {
  final Activity activity;
  final Function(Activity activity) onSelected;
  const ActivityItem({
    Key key,
    this.activity,
    this.onSelected,
  }) : super(key: key);

  @override
  _ActivityItemState createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {
          if (widget.onSelected != null) {widget.onSelected(widget.activity)}
        }, //werkt
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
                            widget?.activity?.name != null
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 0),
                                    child: Text(
                                      widget.activity.name,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                "${widget.activity.dayFormat()}",
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
                              "${ValueParser.distanceDoublePrecise(widget.activity.distance)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${ValueParser.duration(widget.activity.duration)}",
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
