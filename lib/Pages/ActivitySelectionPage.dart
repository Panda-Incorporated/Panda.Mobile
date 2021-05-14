import 'package:flutter/material.dart';
import 'package:panda/DataProvider.dart/ActivityProvider.dart';
import 'package:panda/widgets/CurrentActivities.dart';
import 'package:panda/widgets/Logo.dart';

class ActivitySelectionPage extends StatefulWidget {
  @override
  _ActivitySelectionPageState createState() => _ActivitySelectionPageState();
}

//TODO: fix eenheden
//TODO: generiek maken met fitbitselection
class _ActivitySelectionPageState extends State<ActivitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            stretchTriggerOffset: 200,
            floating: true,
            bottom: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Kies uit Fitbit activiteiten",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.zoomBackground],
              collapseMode: CollapseMode.pin,
              background: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Logo(),
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 300,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ShowActivities(
                  currentActvities: ActivityProvider.getActivity().toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget fitBitActivityRow(context) {
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
                              "subtitle",
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
                            "12 km",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "1.5 u",
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
