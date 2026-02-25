class PasscodeActivateEvent {
  Function()? callback;
  bool isInit;
  bool enableShortCutPasscode;

  PasscodeActivateEvent({
    this.callback,
    this.isInit = false,
    this.enableShortCutPasscode = false,
  });

  @override
  String toString() => 'PasscodeActivateEvent(isInit: $isInit, enableShortCutPasscode: $enableShortCutPasscode)';
}
