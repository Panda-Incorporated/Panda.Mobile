import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Providers/ApiProvider.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/ActivityItem.dart';
import 'package:panda/widgets/CurrentActivities.dart';
import 'package:panda/widgets/Logo.dart';
import 'package:panda/widgets/NothingToDisplay.dart';

class ActivitySelectionPage extends StatefulWidget {
  final Future<void> Function(Activity activity) onSelected;

  const ActivitySelectionPage({Key key, this.onSelected}) : super(key: key);
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
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          child: Logo(),
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kies uit Fitbit activiteiten",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Text(DateFormat().format(selectedDate)),
                      OutlinedButton(
                          child: Text("Datum selecteren"),
                          onPressed: () {
                            _selectDate(context);
                          }),
                      if (loading)
                        Center(child: CircularProgressIndicator())
                      else if (activities != null && activities.length > 0)
                        Column(children: [
                          for (var activity in activities ?? [])
                            ActivityItem(
                              activity: activity,
                              onSelected: (v) {
                                widget.onSelected(v);
                              },
                            )
                        ])
                      else
                        NothingToDisplay(
                          message: "Geen activiteiten bij geselecteerde datum",
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
