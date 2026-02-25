class RemoveMemberStateDataModel {
  String roomId;
  List<String> memberIds;
  bool isAccountDeleted;
  int? memberRequestCount;
  int? memberCount;

  RemoveMemberStateDataModel({
    required this.roomId,
    required this.memberIds,
    required this.isAccountDeleted,
    this.memberRequestCount,
    this.memberCount,
  });

  factory RemoveMemberStateDataModel.fromMap(Map<String, dynamic> data) {
    List<String> memberIds = List<String>.from(data['members']);

    return RemoveMemberStateDataModel(
      roomId: data['_id'],
      memberIds: memberIds,
      isAccountDeleted: data['isAccountDeleted'] ?? false,
      memberRequestCount: data['memberRequestCount'],
      memberCount: data['membership'],
    );
  }
}
