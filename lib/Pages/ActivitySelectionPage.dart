import 'package:flutter/material.dart';
import 'package:panda/DataProvider.dart/ActivityProvider.dart';
import 'package:panda/widgets/widgets.dart';

class ActivitySelectionPage extends StatefulWidget {
  @override
  _ActivitySelectionPageState createState() => _ActivitySelectionPageState();
}

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
                    currentActvities: ActivityProvider.getActivity().toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
