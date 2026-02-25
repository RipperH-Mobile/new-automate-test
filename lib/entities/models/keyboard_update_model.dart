enum KeyboardUpdateType {
  resize,
  open,
  close;

  String get value {
    switch (this) {
      case KeyboardUpdateType.open:
        return 'OPEN';
      case KeyboardUpdateType.close:
        return 'CLOSE';
      case KeyboardUpdateType.resize:
        return 'RESIZE';
    }
  }

  bool get isOpen {
    return this == KeyboardUpdateType.open;
  }

  bool get isClose {
    return this == KeyboardUpdateType.close;
  }

  bool get isResize {
    return this == KeyboardUpdateType.resize;
  }

  static KeyboardUpdateType from(String val) {
    switch (val) {
      case 'OPEN':
        return KeyboardUpdateType.open;
      case 'CLOSE':
        return KeyboardUpdateType.close;
      default:
        return KeyboardUpdateType.resize;
    }
  }
}

class KeyboardUpdateModel {
  double height;
  KeyboardUpdateType type;

  KeyboardUpdateModel({
    required this.height,
    required this.type,
  });

  @override
  bool operator ==(Object other) {
    return other is KeyboardUpdateModel && height == other.height && type == other.type;
  }

  @override
  int get hashCode => height.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'KeyboardUpdateModel{height: $height, type: $type}';
  }
}
