import 'package:flutter/material.dart';

class NewGoalInputAndTextField extends StatelessWidget {
  const NewGoalInputAndTextField({
    Key key,
    @required TextEditingController controller,
    @required String labelText,
    @required String textString,
  })  : _controller = controller,
        _labelText = labelText,
        _textString = textString,
        super(key: key);

  final TextEditingController _controller;
  final String _labelText;
  final String _textString;

  final double _textFontSize = 15;
  final double _inputBoxHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5, bottom: 5, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              _textString,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: _textFontSize),
            )),
        Container(
          height: _inputBoxHeight,
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: _labelText,
            ),
          ),
        ),
      ],
    );
  }
}
