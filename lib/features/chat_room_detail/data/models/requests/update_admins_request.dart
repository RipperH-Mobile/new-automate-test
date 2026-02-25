class UpdateAdminsRequest {
  final String roomId;
  final List<String>? promoteAdmins;
  final List<String>? removeAdmins;

  UpdateAdminsRequest({
    required this.roomId,
    this.promoteAdmins,
    this.removeAdmins,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'promoteAdmins': promoteAdmins,
      'removeAdmins': removeAdmins,
    };
  }
}
