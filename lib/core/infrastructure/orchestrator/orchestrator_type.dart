part of 'orchestrator.dart';

///
/// Enum for orchestrator task types.
/// used to identify the task type and group them into a task group.
///
enum OrchestratorTaskType {
  //
  // Initialize app, confiture firebase, one signal, easy loading, etc.
  // Is run before [runApp()] in main.dart
  // Including register all dependencies in the app.
  // Example for singleton dependencies is [SocketCaller], [HttpCaller], [DbManager], etc.
  //
  initializeApp,

  //
  // For check authentication and database version to migration.
  // Run after app build user interface.
  //
  launchApp,

  //
  // Run after [OrchestratorTaskType.launchApp]
  //
  // When:
  // - user is authenticated
  // - changed user account
  //
  onAuthenticated,

  //
  // On unauthenticated, run when user is logged out.
  //
  // When:
  // - user logged out
  // - before change user account
  //
  onUnAuthenticated,
  onUnAuthenticatedForNormalAccount,

  //
  // On socket is connected, is equal to [onAuthenticated]
  // But this is run when socket is connected.
  // It's mean when socket disconnected, then reconnect and connected again.
  //
  // When:
  // - user is authenticated, first connect.
  // - disconnect and reconnect socket.
  //
  onSocketConnected,

  //
  // Lifecycle trigger
  //
  onAppPaused,
  onAppResumed,
  onAppInactive,
  onAppDetached,
  onAppHidden,

  //
  // Sync trigger
  //
  onSyncInitBeforeWriteToDb,
  onSyncInitAfterWriteToDb,
}
