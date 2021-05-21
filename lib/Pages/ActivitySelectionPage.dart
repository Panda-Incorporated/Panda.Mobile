import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Providers/ApiProvider.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/CurrentActivities.dart';
import 'package:panda/widgets/Logo.dart';

class ActivitySelectionPage extends StatefulWidget {
  @override
  _ActivitySelectionPageState createState() => _ActivitySelectionPageState();
}

//TODO: generiek maken met fitbitselection
class _ActivitySelectionPageState extends State<ActivitySelectionPage> {
  DateTime selectedDate = DateTime.now();
  List<Activity> activities;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState (Reindert af?)
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var authState = await DBProvider.helper.getAuthState();
    activities = await ApiProvider.getActivities(authState, selectedDate);
    setState(() {
      loading = false;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 1825)),
        lastDate: DateTime.now().add(Duration(days: 1825)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      getData();
    }
  }

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
                Text(DateFormat().format(selectedDate)),
                OutlinedButton(
                    child: Text("Datum selecteren"),
                    onPressed: () {
                      _selectDate(context);
                    }),
                if (loading)
                  Center(child: CircularProgressIndicator())
                else if (activities != null)
                  ShowActivities(currentActvities: activities)
                else
                  Center(child: Text("Geen activiteiten om weer te geven."))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
