enum SourcePerformanceState {
  fromClose,
  fromSignIn;

  String get value {
    switch (this) {
      case SourcePerformanceState.fromClose:
        return 'close';
      case SourcePerformanceState.fromSignIn:
        return 'sign-in';
    }
  }
}