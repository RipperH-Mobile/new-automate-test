class UpdateEmailOtpRequest {
  String email;

  UpdateEmailOtpRequest({required this.email});

  Map<String, dynamic> toMap() {
    return {'email': email};
  }
}
