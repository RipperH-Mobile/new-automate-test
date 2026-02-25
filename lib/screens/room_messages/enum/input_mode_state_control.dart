enum InputModeStateControl {
  open,
  close,
  openFullScreen;

  String get value {
    switch (this) {
      case InputModeStateControl.open:
        return 'OPEN';
      case InputModeStateControl.close:
        return 'CLOSE';
      case InputModeStateControl.openFullScreen:
        return 'OPEN_FULL_SCREEN';
    }
  }

  static from(String val) {
    switch (val) {
      case 'OPEN':
        return InputModeStateControl.open;
      case 'CLOSE':
        return InputModeStateControl.close;
      case 'OPEN_FULL_SCREEN':
        return InputModeStateControl.openFullScreen;
    }
  }
}
