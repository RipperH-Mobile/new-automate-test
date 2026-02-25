enum GroupRequestType {
  /// To add that request from request list
  newRequest,

  /// To remove that request from request list
  cancelRequest,

  unknown;

  String get value {
    switch (this) {
      case GroupRequestType.newRequest:
        return 'NEW_REQUEST';
      case GroupRequestType.cancelRequest:
        return 'CANCEL_REQUEST';
      default:
        return 'UNKNOWN';
    }
  }

  static GroupRequestType from(String? val) {
    switch (val) {
      case 'NEW_REQUEST':
        return GroupRequestType.newRequest;
      case 'CANCEL_REQUEST':
        return GroupRequestType.cancelRequest;
      default:
        return GroupRequestType.unknown;
    }
  }
}
