//WARNING DB file: if changed, toMap also needs to be changed and DB rebuild.
import 'package:intl/intl.dart';

class AuthState {
  int id;
  String accessToken;
  DateTime expires;
  String refreshToken;
  String username;
  AuthState();
  AuthState.fill(
      {this.id,
      this.accessToken,
      this.expires,
      this.refreshToken,
      this.username});
  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'expires': DateFormat().format(expires),
      'refreshToken': refreshToken,
      'userName': username,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState.fill(
      id: map['id'],
      accessToken: map['accessToken'],
      expires: DateTime.now().add(Duration(seconds: map['expiresIn'])),
      refreshToken: map['refreshToken'],
      username: map['userName'],
    );
  }
}
