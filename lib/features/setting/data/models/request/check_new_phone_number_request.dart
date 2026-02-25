class CheckNewPhoneNumberRequest {
  String newPhoneNumber;

  CheckNewPhoneNumberRequest({
    required this.newPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'newPhoneNumber': newPhoneNumber,
    };

    return json;
  }
}
