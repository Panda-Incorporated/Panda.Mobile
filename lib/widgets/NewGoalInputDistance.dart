import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:intl/intl.dart';

class NewGoalInputDistance extends StatelessWidget {
  NewGoalInputDistance({
    Key key,
    @required TextEditingController controller,
    @required String labelText,
    @required String textString,
    TextInputType keyboardType,
    List<TextInputFormatter> inputFormatters,
    this.onDateSelected,
  })  : _controller = controller,
        _labelText = labelText,
        _textString = textString,
        super(key: key);

  final Function(DateTime) onDateSelected;

  final TextEditingController _controller;
  final String _labelText;
  final String _textString;

  final double _textFontSize = 15;
  final double _inputBoxHeight = 50;
  DateTime _selectedDate = DateTime.now();

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
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
            ],
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: _labelText,
            ),
          ),
        ),
      ],
    );
  }

  void setState(Null Function() param0) {}
}
