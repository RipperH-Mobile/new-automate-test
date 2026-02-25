# Orchestrator

The Orchestrator is a central system in the UChatMessenger application that manages initialization sequences, lifecycle events, and coordination of tasks across the app. It provides a structured approach to handling complex, interdependent operations throughout the application lifecycle.

## Overview

The Orchestrator follows a task-based architecture where:

1. **Task Types** define different phases of the application lifecycle
2. **Task Groups** organize related tasks together
3. **Individual Tasks** perform specific operations

This approach allows for:
- Centralized management of initialization and lifecycle sequences
- Parallel or sequential task execution based on requirements
- Conditional execution based on application state
- Performance monitoring and error handling

## Core Components

### 1. OrchestratorTaskType

An enum that defines different phases of the application lifecycle:

```dart
enum OrchestratorTaskType {
  // App startup
  initializeApp,      // Before Flutter runApp()
  launchApp,          // After UI built, handles auth checks and DB migrations

  // Authentication
  onAuthenticated,    // When user logs in or switches accounts
  onUnAuthenticated,  // When user logs out
  onUnAuthenticatedForNormalAccount,  // Specific logout tasks for normal accounts

  // Network
  onSocketConnected,  // When socket connection is established

  // App lifecycle
  onAppPaused,        // App goes to background
  onAppResumed,       // App comes to foreground
  onAppInactive,      // App is inactive
  onAppDetached,      // App is detached
  onAppHidden,        // App is hidden

  // Sync operations
  onSyncInitBeforeWriteToDb,  // Before writing sync data to DB
  onSyncInitAfterWriteToDb,   // After writing sync data to DB
}
```

### 2. OrchestratorTask

Represents a group of related tasks that should be executed together:

```dart
class OrchestratorTask {
  // Task identifier (kebab-case)
  final String id;
  
  // List of tasks to execute
  final List<OrchestratorTaskFunction> tasks;
  
  // Whether to run tasks in parallel or sequentially
  final bool runParallel;
  
  // Optional condition to check before executing
  final OrchestratorConditionFunction? condition;
}
```

### 3. Configuration

The `config.dart` file contains the task configuration for each task type. This is where you define which tasks should be executed during each phase of the application lifecycle.

## How It Works

### Execution Flow

1. An application event triggers a task type (e.g., app launch, user login)
2. The Orchestrator looks up task groups for that task type
3. For each task group:
   - The condition is checked (if specified)
   - Tasks are executed in parallel or sequentially based on configuration
   - Performance metrics are tracked
   - Errors are handled according to the stopOnError parameter

### Example: Execution of initializeApp

When the application starts:

1. `OrchestratorTaskType.initializeApp` is triggered
2. The following task groups are executed in order:
   - `initialize-app-begin`: Basic setup tasks
   - `initialize-analytics`: Sets up analytics services
   - `initialize-app-core`: Initializes core services
   - `register-singleton-dependencies`: Registers singleton dependencies
   - `initialize-singleton-dependencies`: Initializes registered singletons
   - `register-factory-dependencies`: Registers factory dependencies
   - `manage-legacy-dependencies`: Sets up legacy controllers

## Task Types in Detail

### Application Startup

#### `initializeApp`
Runs before `runApp()` in main.dart. Sets up essential services and dependencies.

Tasks include:
- Initialize logger services
- Configure analytics
- Set up third-party libraries
- Register and initialize singleton dependencies
- Register factory dependencies
- Set up permanent controllers

#### `launchApp`
Runs after `runApp()`, before the app is shown to the user.

Tasks include:
- Hide splash screen
- Initialize Google Maps
- Check passcode
- Initialize package info
- Fetch public configuration
- Check app version
- Clear notifications

### Authentication Flow

#### `onAuthenticated`
Runs after user authentication when user information is loaded.

Tasks include:
- Start sync process
- Set up local services (connectivity, call, audio, permissions)
- Initialize subscription data and in-app purchases
- Update user-specific components
- Start heartbeat and monitoring systems

#### `onUnAuthenticated`
Runs when the user logs out.

Tasks include:
- Stop sync process
- Clean up user-specific controllers
- Remove OneSignal user
- Stop heartbeat and monitoring

#### `onUnAuthenticatedForNormalAccount`
Additional tasks for normal (non-debug) account logout.

Tasks include:
- Clear sync state sequences
- Clean up notification data
- Clear user data
- Clear passcode configuration

### Network Management

#### `onSocketConnected`
Runs when socket connection is established.

Tasks include:
- Sync state (if reconnecting)
- Update chat list, notifications, contacts
- Verify in-app purchases
- Check connection quality

### App Lifecycle

#### `onAppResumed`
Runs when the app comes to the foreground.

Tasks include:
- Start heartbeat and monitoring
- Reconnect socket if needed
- Start sync process
- Resume media viewer
- Check permissions and app version

#### `onAppPaused`
Runs when the app goes to the background.

Tasks include:
- Stop heartbeat
- Disconnect socket
- Stop monitoring systems
- Stop network monitor

### Sync Operations

#### `onSyncInitBeforeWriteToDb` and `onSyncInitAfterWriteToDb`
Handle sync operations before and after writing to the database.

## Adding New Tasks

To add a new task to the Orchestrator:

1. Identify the appropriate `OrchestratorTaskType`
2. Update the `tasks` map in `config.dart`
3. Add your task function to an existing task group or create a new one

Example:

```dart
OrchestratorTaskType.onAuthenticated: [
  // Existing task groups...
  
  // Add a new task group
  OrchestratorTask(
    id: 'on-authenticated-my-new-feature',
    tasks: [
      () => MyFeatureController.instance.initialize(),
      () => MyFeatureService.instance.fetchInitialData(),
    ],
  ),
],
```

## Best Practices

1. **Task Organization:**
   - Keep related tasks in the same group
   - Use descriptive ID names for task groups
   - Consider task execution order when organizing groups

2. **Parallel vs. Sequential Execution:**
   - Use parallel execution (`runParallel = true`) for independent tasks
   - Use sequential execution for tasks that depend on previous tasks
   - Be careful with parallel execution when tasks modify shared state

3. **Conditional Execution:**
   - Use conditions to avoid unnecessary task execution
   - Keep conditions lightweight and focused

4. **Error Handling:**
   - Consider whether errors should stop execution (use `stopOnError`)
   - Make sure tasks handle their own errors appropriately
   - Log errors with proper context for debugging

5. **Performance:**
   - Monitor task execution time with performance traces
   - Optimize or parallelize slow tasks
   - Consider moving non-essential tasks to later phases

## Debugging

The Orchestrator logs the execution of task groups with detailed information about:
- When each group starts and finishes
- Any errors that occur during execution
- Performance metrics for task groups

For more detailed debugging, you can add custom logs within task functions.

## Common Patterns and Examples

### Initialization Sequence

```dart
// In main.dart
Future<void> main() async {
  // Run initialization tasks before Flutter setup
  await Orchestrator.run(OrchestratorTaskType.initializeApp);
  
  // Initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Run app
  runApp(MyApp());
  
  // Run launch tasks after app is built
  await Orchestrator.run(OrchestratorTaskType.launchApp);
}
```

### Authentication Tasks

```dart
// When user logs in
void onUserLoggedIn() async {
  await Orchestrator.run(OrchestratorTaskType.onAuthenticated);
}

// When user logs out
void onUserLoggedOut() async {
  await Orchestrator.run(OrchestratorTaskType.onUnAuthenticated);
  
  // Run additional tasks for normal accounts
  if (!isDebugAccount) {
    await Orchestrator.run(OrchestratorTaskType.onUnAuthenticatedForNormalAccount);
  }
}
```

### Lifecycle Management

```dart
// In app lifecycle management
void handleAppLifecycleState(AppLifecycleState state) async {
  switch (state) {
    case AppLifecycleState.resumed:
      await Orchestrator.run(OrchestratorTaskType.onAppResumed);
      break;
    case AppLifecycleState.paused:
      await Orchestrator.run(OrchestratorTaskType.onAppPaused);
      break;
    // Handle other states...
  }
}
```

## Advanced Usage

### Creating Complex Task Dependencies

For more complex task dependencies, you can chain conditions and task completions:

```dart
OrchestratorTask(
  id: 'complex-dependent-task',
  condition: () async {
    // Check multiple conditions
    final isFeatureEnabled = await FeatureService.isEnabled();
    final hasPermission = await PermissionService.checkPermission();
    return isFeatureEnabled && hasPermission;
  },
  tasks: [
    // Task 1: Prepare data
    () async {
      final data = await DataService.fetchData();
      // Store data for next task
      SharedState.setData(data);
    },
    
    // Task 2: Process prepared data
    () async {
      final data = SharedState.getData();
      if (data != null) {
        await ProcessingService.process(data);
      }
    },
  ],
  runParallel: false, // Ensure sequential execution
)
```

### Dynamic Task Configuration

You can dynamically add or remove tasks based on runtime conditions:

```dart
// Create a base task list
final List<OrchestratorTaskFunction> baseTasks = [
  () => BasicService.initialize(),
];

// Add optional tasks based on conditions
if (isFeatureEnabled) {
  baseTasks.add(() => OptionalFeature.initialize());
}

// Create the task group
OrchestratorTask(
  id: 'dynamic-task-group',
  tasks: baseTasks,
)
```

## Conclusion

The Orchestrator provides a powerful framework for managing complex task sequences in the UChatMessenger application. By organizing tasks into logical groups and phases, it ensures that initialization, authentication, and lifecycle events are handled in a consistent and maintainable way.

When implementing new features or refactoring existing ones, consider how the Orchestrator can help coordinate the necessary tasks and maintain clean dependencies between different parts of the application.