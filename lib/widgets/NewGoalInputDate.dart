import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:intl/intl.dart';

class NewGoalInputDate extends StatelessWidget {
  NewGoalInputDate({
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
              LengthLimitingTextInputFormatter(20),
            ],
            onTap: () async {
              DateTime picked = await showDatePicker(
                // ! HELP MIJ
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 1825)),
              );
              if (picked != null && picked != _selectedDate) {
                _controller.text = DateFormat("dd/MM/yyyy").format(picked);
                setState(() {
                  _selectedDate = picked;
                  _controller.text = DateFormat.yMd().format(_selectedDate);
                });
                if (onDateSelected != null) {
                  onDateSelected(_selectedDate);
                }
              }
            },
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

  void setState(Null Function() param0) {}
}
