class PasscodeLaunchEvent {
  Function()? callback;
  bool isDebug;

  PasscodeLaunchEvent({
    this.callback,
    this.isDebug = false,
  });

  @override
  String toString() => 'PasscodeLaunchEvent(isDebug: $isDebug)';
}
