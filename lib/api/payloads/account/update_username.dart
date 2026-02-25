class UpdateUsernameRequest {
  String username;

  UpdateUsernameRequest({
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {'username': username};
  }
}
