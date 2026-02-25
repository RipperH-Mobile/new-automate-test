class OtpEntity {
  final String? token;
  final String? ref;
  final String? type;
  final DateTime? firstGet;
  final DateTime? timeout;
  final String? actionToken;

  const OtpEntity({
    this.token,
    this.ref,
    this.type,
    this.firstGet,
    this.timeout,
    this.actionToken,
  });
  
  OtpEntity copyWith({
    String? token,
    String? ref,
    String? type,
    DateTime? firstGet,
    DateTime? timeout,
    String? actionToken,
  }) {
    return OtpEntity(
      token: token ?? this.token,
      ref: ref ?? this.ref,
      type: type ?? this.type,
      firstGet: firstGet ?? this.firstGet,
      timeout: timeout ?? this.timeout,
      actionToken: actionToken ?? this.actionToken,
    );
  }
}
