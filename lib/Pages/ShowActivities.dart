import 'package:flutter/material.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/Goal.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/CurrentActivities.dart';
import 'package:panda/widgets/NothingToDisplay.dart';

class ShowActivitiesPage extends StatefulWidget {
  final Goal goal;

  const ShowActivitiesPage({Key key, this.goal}) : super(key: key);
  @override
  _ShowActivitiesPageState createState() => _ShowActivitiesPageState();
}

class _ShowActivitiesPageState extends State<ShowActivitiesPage> {
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
    if (widget?.goal?.id != null) {
      activities = await DBProvider.helper
          .getActivities(where: "goalId=?", whereArgs: [widget.goal.id]);
    } else {
      activities = await DBProvider.helper.getActivities();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.goal?.title != null
            ? "Activiteiten van " + widget.goal.title
            : "Alle activiteiten"),
      ),
      body: ListView(
        children: [
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : activities != null && activities.length > 0
                  ? ShowActivities(
                      currentActvities: activities,
                    )
                  : NothingToDisplay(),
        ],
      ),
    );
  }
}
