class LinkEmailOtpRequest {
  final String email;

  LinkEmailOtpRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
