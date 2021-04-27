import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image(
        height: 240,
        image: AssetImage('lib/assets/panda.png'),
      ),
    );
  }
}
