class AuthLoginRequest {
  String username;
  String password;

  AuthLoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }
}
