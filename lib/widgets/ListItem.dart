import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panda/Utils/Pair.dart';
import 'package:panda/widgets/pie_chart_sections.dart';

class ListItem extends StatefulWidget {
  ListItem({
    Key key,
    this.title,
    this.subTitle,
    this.percentage,
  }) : super(key: key) {
    this.extended = false;
    this.extendedItems = const [];
  }
  ListItem.extended(
      {Key key,
      this.title,
      this.subTitle,
      this.percentage,
      List<Pair<String, String>> extendedItems})
      : super(key: key) {
    this.extended = true;
    this.extendedItems = extendedItems;
  }

  @override
  _ListItemState createState() => _ListItemState();
  final String title;
  final String subTitle;
  final int percentage;
  bool extended;
  List<Pair<String, String>> extendedItems;
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                                widget.title,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: Text(
                                widget.subTitle,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // hier zou dan de check moeten komen
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border:
                                    Border.all(color: Colors.green, width: 6.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: Text(
                                widget.percentage.toString() + "%",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.extended)
                  Divider(
                    thickness: 0.5,
                    indent: 6,
                    endIndent: 6,
                    height: 10,
                    // zwarte lijn dat nog in de main column zit
                    color: Colors.cyan[900],
                  ),
                if (widget.extended)
                  for (var item in widget.extendedItems)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 2.0, bottom: 8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  child: Text(
                                    item.first ?? "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.circle,
                                          size: 8.0,
                                        ),
                                      ),
                                      Text(
                                        item.last ?? "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        )
                      ],
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
