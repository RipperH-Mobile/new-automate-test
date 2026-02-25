enum CallStatusType {
  newCall,
  created,
  startCall,
  calling,
  inProgress,
  failed,
  completed;

  String get value {
    switch (this) {
      case CallStatusType.newCall:
        return 'NEW';
      case CallStatusType.created:
        return 'CREATED';
      case CallStatusType.startCall:
        return 'START_CALL';
      case CallStatusType.calling:
        return 'CALLING';
      case CallStatusType.inProgress:
        return 'IN_PROGRESS';
      case CallStatusType.failed:
        return 'FAILED';
      case CallStatusType.completed:
        return 'COMPLETED';
    }
  }

  static from(String val) {
    switch (val) {
      case 'NEW':
        return CallStatusType.newCall;
      case 'CREATED':
        return CallStatusType.created;
      case 'START_CALL':
        return CallStatusType.startCall;
      case 'CALLING':
        return CallStatusType.calling;
      case 'IN_PROGRESS':
        return CallStatusType.inProgress;
      case 'FAILED':
        return CallStatusType.failed;
      case 'COMPLETED':
        return CallStatusType.completed;
    }
  }
}
