class AuthState {
  String accessToken;
  int expiresIn;
  String refreshToken;
  String username;
  AuthState.fill(
      {this.accessToken, this.expiresIn, this.refreshToken, this.username});
}
