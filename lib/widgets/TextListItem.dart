import 'package:flutter/material.dart';

class TextListItem extends StatefulWidget {
  final Function onTap;
  final String title;
  final String subTitle;
  final Widget extra;

  const TextListItem(
      {Key key, this.onTap, this.title, this.subTitle, this.extra})
      : super(key: key);
  @override
  _TextListItemState createState() => _TextListItemState();
}

class _TextListItemState extends State<TextListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget
            .onTap, //navigeren naar goal summaary page en dan goal meegeven
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(6))),

          // kleur knop

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // helemaal links helemaal rechts
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.subTitle,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0), child: widget.extra),
            ],
          ),
        ),
      ),
    );
  }
}
