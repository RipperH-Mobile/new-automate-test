class SetRoomThemeRequest {
  final String roomId;
  final String theme;

  SetRoomThemeRequest({
    required this.roomId,
    required this.theme,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'theme': theme,
    };
  }
}
