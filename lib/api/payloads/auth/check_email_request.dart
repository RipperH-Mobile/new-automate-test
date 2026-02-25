class CheckEmailRequest {
  final String email;

  CheckEmailRequest({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}
