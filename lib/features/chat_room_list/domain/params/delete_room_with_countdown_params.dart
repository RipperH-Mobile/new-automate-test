class DeleteRoomWithCountdownParams {
  final String roomId;

  /// Function to be executed after countdown and delete is finished, undo is pressed or force delete is called.
  final Function? onCompleteCallback;

  /// If true, Will send delete request with forceDelete = true to server and server will delete the room immediately.
  /// and will not show the countdown toast.
  final bool forceDelete;
  void Function()? function;

  DeleteRoomWithCountdownParams({
    required this.roomId,
    this.onCompleteCallback,
    this.forceDelete = false,
    this.function,
  });
}
