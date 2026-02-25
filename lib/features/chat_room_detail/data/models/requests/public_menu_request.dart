class PublicMenuRequest {
  final String roomId;

  PublicMenuRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
