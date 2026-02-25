enum CustomInputMode {
  gif,
  sticker,
  emoji;

  String get value {
    switch (this) {
      case CustomInputMode.gif:
        return 'GIF';
      case CustomInputMode.sticker:
        return 'STICKER';
      case CustomInputMode.emoji:
        return 'EMOJI';
    }
  }

  int get num {
    switch (this) {
      case CustomInputMode.gif:
        return 0;
      case CustomInputMode.sticker:
        return 1;
      case CustomInputMode.emoji:
        return 2;
    }
  }

  static from(String val) {
    switch (val) {
      case 'GIF':
        return CustomInputMode.gif;
      case 'STICKER':
        return CustomInputMode.sticker;
      case 'EMOJI':
        return CustomInputMode.emoji;
    }
  }
}
