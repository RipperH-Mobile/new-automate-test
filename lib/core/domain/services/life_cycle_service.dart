import '../enums/app_state.dart';

abstract class LifeCycleService {
  AppState get appState;

  bool get isInactive;

  bool get isPaused;

  bool get isActive;
}
