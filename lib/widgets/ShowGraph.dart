import 'package:flutter/material.dart';

class ShowGraph extends StatefulWidget {
  final String data;

  const ShowGraph({Key key, this.data}) : super(key: key);

  @override
  _ShowGraphState createState() => _ShowGraphState(data);
}

class _ShowGraphState extends State<ShowGraph> {
  String data;

  _ShowGraphState(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            data,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.cyanAccent[700],
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Container(
                child: Center(
                  child: Text(
                    data + " weergeven",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
