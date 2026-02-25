class ChangeLockMessagePasswordArguments {
  String roomId;
  String? oldPassword;

  ChangeLockMessagePasswordArguments({
    required this.roomId,
    this.oldPassword,
  });
}
