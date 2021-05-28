import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Providers/DBProvider.dart';

class ApiProvider {
  static final ValueNotifier<bool> needsReauthentication =
      ValueNotifier<bool>(false);
  static final String url = "https://pandaapi.azurewebsites.net/";
  static final String accesstoken = "accesstoken";
  static final String refreshToken = "refreshtoken";
  static final String activities = "api/activity";
  static Future<AuthState> getAccessToken(String code) async {
    var resp = await http.get(Uri.parse("$url$accesstoken?code=$code"));
    if (resp.statusCode == 200) {
      needsReauthentication.value = false;
      return AuthState.fromMap(jsonDecode(resp.body));
    }
  }

  static Future<AuthState> getAccessTokenUsingRefreshToken(String token) async {
    needsReauthentication.value = false;

    var resp = await http.get(Uri.parse("$url$refreshToken/$token"));
    if (resp.statusCode == 200) {
      needsReauthentication.value = false;
      return AuthState.fromMap(jsonDecode(resp.body));
    } else {
      needsReauthentication.value = true;
    }
  }

  static Future<AuthState> checkAccessToken(AuthState authState) async {
    if (authState.accessToken != null) {
      //This checks if the current time is after the expire date minus 10 minutes to have a margin of error.
      if (DateTime.now()
          .isAfter(authState.expires.subtract(Duration(minutes: 10)))) {
        if (authState.refreshToken != null) {
          var res =
              await getAccessTokenUsingRefreshToken(authState.refreshToken);
          authState.accessToken = res.accessToken;
          authState.expires = res.expires;
          authState.refreshToken = res.refreshToken;
          DBProvider.helper.updateAuthState(authState);
          return authState;
        } else {
          needsReauthentication.value = true;
        }
      } else {
        return authState;
      }
    } else {
      needsReauthentication.value = true;
    }
  }

  static Future<List<Activity>> getActivities(
      AuthState authState, DateTime dateTime) async {
    var auth = await checkAccessToken(authState);
    var accessToken = auth.accessToken;
    var resp = await http.get(Uri.parse(
        "$url$activities?accessToken=$accessToken&dateTime=" +
            DateFormat("yyyy-MM-dd").format(dateTime)));
    if (resp.statusCode == 200) {
      return (jsonDecode(resp.body) as List)
          .map((e) => Activity.fromMap(e, dateTime: dateTime))
          .toList();
    } else {
      return List.empty();
    }
  }
}

class NotSignedInException implements Exception {
  /// A message describing the error.
  final String message;

  /// Creates a new NotSignedInException with an optional error [message].
  const NotSignedInException([this.message = ""]);

  String toString() => "NotSignedInException: $message";
}
