import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/AuthState.dart';

class ApiProvider {
  static final String url = "https://pandaapi.azurewebsites.net/";
  static final String accesstoken = "/accesstoken";
  static final String activities = "/api/activity";
  static Future<AuthState> getAccessToken(String code) async {
    var resp = await http.get(Uri.parse("$url$accesstoken?code=$code"));
    if (resp.statusCode == 200) {
      return AuthState.fromMap(jsonDecode(resp.body));
    }
  }

  static Future<List<Activity>> getActivities(
      String accessToken, DateTime dateTime) async {
    var resp = await http.get(Uri.parse(
        "$url$activities?accessToken=$accesstoken&dateTime=" +
            DateFormat().format(dateTime)));
    if (resp.statusCode == 200) {
      return (jsonDecode(resp.body) as List)
          .map((e) => Activity.fromMap(e))
          .toList();
    }
  }
}
