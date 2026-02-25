class SelectOtpTypeRequest {
  bool? isEmail;
  bool? isPhoneNumber;
  bool? isRemoveAccount;

  SelectOtpTypeRequest({
    this.isEmail,
    this.isPhoneNumber,
    this.isRemoveAccount,
  });

  Map<String, dynamic> toMap() {
    if (isEmail == null && isPhoneNumber == null) {
      throw Exception('Both isEmail and isPhoneNumber can not be null.');
    }

    Map<String, dynamic> json = {};

    if (isEmail != null) {
      json['isEmail'] = isEmail;
    }

    if (isPhoneNumber != null) {
      json['isPhoneNumber'] = isPhoneNumber;
    }

    if (isRemoveAccount != null) {
      json['isRemoveAccount'] = isRemoveAccount;
    }

    return json;
  }
}
