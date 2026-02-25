import 'package:get/get.dart';
import 'package:uchat/core/domain/enums/app_state.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

import '../../domain/services/life_cycle_service.dart';
import '../../infrastructure/analytics/logger_service.dart';
import '../../infrastructure/orchestrator/orchestrator.dart';

class LifeCycleServiceImpl extends FullLifeCycleController with FullLifeCycleMixin implements LifeCycleService {
  AppState _appState = AppState.active;

  @override
  AppState get appState => _appState;

  @override
  bool get isInactive => _appState == AppState.inactive;

  @override
  bool get isPaused => _appState == AppState.paused;

  @override
  bool get isActive => _appState == AppState.active;

  @override
  void onReady() {
    useLogger().d('LifeCycle: onReady');
    _appState = AppState.active;
  }

  @override
  void onInactive() {
    if (_appState == AppState.inactive) {
      useLogger().d('LifeCycle: onInactive called but app is already inactive.');
      return;
    }

    useLogger().d('LifeCycle: onInactive');
    _appState = AppState.inactive;
    Orchestrator.run(OrchestratorTaskType.onAppInactive);

    // TODO: Move to self scope
    eventBus.fire(AppInactiveEvent());
    // MediaViewerService.instance.onAppInActive();
    // onShowPrivacyScreen();
  }

  @override
  void onPaused() {
    if (_appState == AppState.paused) {
      useLogger().d('LifeCycle: onPaused called but app is already paused.');
      return;
    }

    useLogger().d('LifeCycle: onPaused');
    _appState = AppState.paused;
    Orchestrator.run(OrchestratorTaskType.onAppPaused);
  }

  @override
  void onResumed() async {
    if (_appState == AppState.active) {
      useLogger().d('LifeCycle: onResumed called but app is already active.');
      return;
    }

    useLogger().d('LifeCycle: onResumed -> active');
    _appState = AppState.active;
    await Orchestrator.run(OrchestratorTaskType.onAppResumed);
  }

  @override
  void onDetached() {
    if (_appState == AppState.detached) {
      useLogger().d('LifeCycle: onDetached called but app is already detached.');
      return;
    }

    useLogger().d('LifeCycle: onDetached');
    _appState = AppState.detached;
    Orchestrator.run(OrchestratorTaskType.onAppDetached);
  }

  @override
  void onHidden() {
    if (_appState == AppState.hidden) {
      useLogger().d('LifeCycle: onHidden called but app is already hidden.');
      return;
    }

    useLogger().d('LifeCycle: onHidden');
    _appState = AppState.hidden;
    Orchestrator.run(OrchestratorTaskType.onAppHidden);
  }
}
