sealed class CheckUserEntity {}

class CheckUserOtpEntity extends CheckUserEntity {
  final String? token;
  final String? ref;
  final String? type;
  final DateTime? firstGet;
  final DateTime? timeout;
  final String? phoneNumber;
  final String? email;
  final String? actionToken;

  CheckUserOtpEntity({
    this.token,
    this.ref,
    this.type,
    this.firstGet,
    this.timeout,
    this.phoneNumber,
    this.email,
    this.actionToken,
  });
}

class CheckUserPasswordEntity extends CheckUserEntity {
  final bool? passwordRequired;

  CheckUserPasswordEntity({
    this.passwordRequired,
  });
}
