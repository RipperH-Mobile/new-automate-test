class SendReasonCancelRequest {
  String reason;
  String? description;
  String? type;

  SendReasonCancelRequest({
    required this.reason,
    this.description,
    this.type,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'reason': reason,
      'description': description,
      'type': type,
    };
  }
}
