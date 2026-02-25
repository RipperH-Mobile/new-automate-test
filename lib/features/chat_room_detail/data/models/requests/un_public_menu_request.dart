class UnPublicMenuRequest {
  final String roomId;

  UnPublicMenuRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
