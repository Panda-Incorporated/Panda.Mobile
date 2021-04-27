import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Green', percent: 70, color: const Color(0xff0293ee)),
    Data(name: 'Orange', percent: 30, color: const Color(0xfff8b250)),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}
