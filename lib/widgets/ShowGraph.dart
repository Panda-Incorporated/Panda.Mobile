import 'package:flutter/material.dart';

class FullPageButtonBase extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final Function onTap;

  const FullPageButtonBase(
      {Key key, this.title, @required this.onTap, this.buttonTitle})
      : super(key: key);

  @override
  _FullPageButtonBaseState createState() => _FullPageButtonBaseState();
}

class _FullPageButtonBaseState extends State<FullPageButtonBase> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title == null
            ? Container()
            : Container(
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
            onTap: widget.onTap ?? () {},
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Container(
                  child: Center(
                    child: Text(
                      widget.buttonTitle ?? widget.title,
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

class FullPageButton extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final Widget onTap;

  const FullPageButton(
      {Key key, this.title, @required this.onTap, this.buttonTitle})
      : super(key: key);

  @override
  _FullPageButtonState createState() => _FullPageButtonState();
}

class _FullPageButtonState extends State<FullPageButton> {
  @override
  Widget build(BuildContext context) {
    return FullPageButtonBase(
        title: widget.title,
        buttonTitle: widget.buttonTitle,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.onTap),
          );
        });
  }
}
