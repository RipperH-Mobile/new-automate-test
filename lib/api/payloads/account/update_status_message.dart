class UpdateStatusMessageRequest {
  String statusMessage;

  UpdateStatusMessageRequest({
    required this.statusMessage,
  });

  Map<String, dynamic> toMap() {
    return {'statusMessage': statusMessage};
  }
}
