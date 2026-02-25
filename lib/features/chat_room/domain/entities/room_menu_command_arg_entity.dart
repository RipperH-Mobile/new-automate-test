/// Entity to store data required for room menu action's specific task.
/// At least one of [username], [roomGroupId], [url] must not be null Because action need this data to do its job.
class RoomMenuCommandArgEntity {
  /// Username of user to add friend if [RoomMenuActionEntity]'s command is [RoomMenuActionModel.commandAddFriendAndChat]
  /// will be null otherwise.
  final String? username;

  /// Room id of group to request to join if [RoomMenuActionEntity]'s command is [RoomMenuActionModel.commandJoinGroup]
  /// will be null otherwise.
  final String? roomGroupId;

  /// Url to open if [RoomMenuActionEntity]'s command is [RoomMenuActionModel.commandOpenUrl]
  /// will be null otherwise.
  final String? url;

  RoomMenuCommandArgEntity({
    this.username,
    this.roomGroupId,
    this.url,
  });
}
