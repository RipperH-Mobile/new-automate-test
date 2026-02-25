class UpdatePhoneNumberRequest {
  String actionToken;
  String newPhoneNumber;

  UpdatePhoneNumberRequest({
    required this.actionToken,
    required this.newPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'actionToken': actionToken,
      'newPhoneNumber': newPhoneNumber,
    };

    return json;
  }
}

class UpdatePhoneNumberResponse {
  final String? id;
  final String? phoneNumber;

  UpdatePhoneNumberResponse({
    this.id,
    this.phoneNumber,
  });

  factory UpdatePhoneNumberResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePhoneNumberResponse(
      id: json['_id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );
  }

  @override
  String toString() {
    return 'UpdatePhoneNumberResponse{id: $id, phoneNumber: $phoneNumber}';
  }
}
