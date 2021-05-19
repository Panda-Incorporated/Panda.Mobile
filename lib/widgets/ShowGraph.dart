import 'package:flutter/material.dart';

class ShowGraph extends StatefulWidget {
  final String title;
  final Widget onTap;

  const ShowGraph({Key key, @required this.title, @required this.onTap})
      : super(key: key);

  @override
  _ShowGraphState createState() => _ShowGraphState();
}

class _ShowGraphState extends State<ShowGraph> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        GestureDetector(
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => widget.onTap),
                  )
                },
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.cyanAccent[700],
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Container(
                  child: Center(
                    child: Text(
                      widget.title + "weergeven",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
