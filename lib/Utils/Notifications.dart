import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications {
  static _showActionbar(
      BuildContext context, Function onPressed, String action, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          },
          label: action,
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(text)));
  }

  static _showbar(BuildContext context, {@required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(text)));
  }

  static show(BuildContext context,
      {Function onPressed, String action, @required String text}) {
    if (action == null || onPressed == null) {
      _showbar(context, text: text);
    } else {
      _showActionbar(context, onPressed, action, text);
    }
  }
}
