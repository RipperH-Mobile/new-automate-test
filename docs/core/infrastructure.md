# Infrastructure

The `infrastructure` directory within the core folder provides essential low-level services and utilities that support the entire application. This layer connects the application to external systems, frameworks, and services while maintaining clean architecture principles.

## Structure

```
infrastructure/
├── analytics/                             # Analytics and logging systems
│   ├── crashlytics_service.dart           # Firebase Crashlytics integration
│   ├── logger/                            # Logging implementation
│   │   ├── filter.dart                    # Filters for controlling log output
│   │   ├── message.dart                   # Log message formatting
│   │   └── output.dart                    # Log output destinations
│   ├── logger_service.dart                # Centralized logging service
│   ├── metric/                            # Performance metrics
│   │   ├── duration.dart                  # Duration measurement utilities
│   │   └── performance_trace.dart         # Performance tracing utilities
│   └── performance_service.dart           # Performance monitoring service
├── app/                                   # Application infrastructure
│   └── app.dart                           # Core application setup
├── notification/                          # Notification infrastructure
│   └── one_signal.dart                    # OneSignal integration
└── orchestrator/                          # Application initialization orchestrator
    ├── common/                            # Shared components for orchestrator
    │   ├── task_group.dart                # Task grouping utilities
    │   └── typedef.dart                   # Type definitions
    ├── config.dart                        # Orchestrator configuration
    ├── navigation/                        # Navigation coordination
    │   ├── deep_link_handler.dart         # Deep link handling
    │   ├── navigation_coordinator.dart    # Navigation coordination
    │   └── share_handler.dart             # Content sharing handling
    ├── orchestrator.dart                  # Main orchestrator implementation
    ├── orchestrator_type.dart             # Orchestrator task types
    └── tasks/                             # Orchestrator initialization tasks
        ├── factory_dependencies.dart      # Factory dependency registration
        ├── initialize_analytic.dart       # Analytics initialization
        ├── initialize_app.dart            # App initialization
        ├── launch_app.dart                # App launch sequence
        ├── on_authenticated.dart          # Authentication handling
        ├── permanent_controller.dart      # Permanent controllers setup
        └── singleton_dependencies.dart    # Singleton dependency registration
```

## Key Components

### Analytics System

The analytics system provides logging, performance monitoring, and crash reporting throughout the application:

- **Logger Service**: A centralized logging service that integrates with multiple logging systems (Flutter Logger, Talker) to provide consistent logging across the app.
  - Supports different log levels (debug, info, warning, error, fatal)
  - Provides filtering capabilities to control log verbosity
  - Includes custom output formatting and configuration
  - Handles troubleshooting data collection and reporting

- **Performance Service**: Tracks and monitors performance metrics across the application:
  - Creates performance traces for measuring operation durations
  - Helps identify performance bottlenecks
  - Integrates with Firebase Performance Monitoring

- **Crashlytics Service**: Handles crash reporting to Firebase Crashlytics:
  - Captures and reports unhandled exceptions
  - Records custom keys and logs for better crash diagnostics

### Orchestrator System

The orchestrator is an essential system that manages the application's initialization and lifecycle events:

#### Key Concepts

1. **Task Types**: Defined in `orchestrator_type.dart`, these represent different phases of the application lifecycle:
   - `initializeApp`: Runs before the Flutter app starts, setting up Firebase, OneSignal, etc.
   - `launchApp`: Runs after the UI is built, handling authentication checks and database migrations
   - `onAuthenticated`: Runs when a user logs in or switches accounts
   - `onUnAuthenticated`: Runs when a user logs out
   - `onSocketConnected`: Runs when the socket connection is established
   - Additional lifecycle hooks for app state changes (paused, resumed, inactive, etc.)

2. **Task Groups**: Defined in `task_group.dart`, these group related tasks together:
   - Can be run in parallel or sequentially
   - Can have conditional execution based on app state
   - Track performance metrics for execution time

3. **Tasks**: Individual operations to be performed during different phases
   - Run in a specified order within their group
   - Can be monitored for performance and errors

#### How It Works

The orchestrator follows these execution steps:

1. An orchestrator task type is triggered by an application event (e.g., app launch, user login)
2. The orchestrator looks up task groups associated with the task type
3. For each task group:
   - Determines if the group's condition is met for execution
   - Executes tasks in parallel or sequence based on the group's configuration
   - Tracks performance metrics for the execution
   - Handles and optionally reports errors

#### Navigation Coordination

The navigation coordination components within the orchestrator manage:

- **Deep Links**: Handling incoming deep links to navigate to the appropriate screens
- **Navigation Coordination**: Centralized navigation state management and routing
- **Share Handling**: Managing content sharing between the app and other applications

### Notification System

Integrates with OneSignal to provide push notification capabilities:

- Handles notification registration, delivery, and presentation
- Manages notification permissions and user preferences
- Processes notification data for appropriate app responses

## Usage Examples

### Orchestrator Usage

The orchestrator is typically used to perform initialization tasks and respond to lifecycle events:

```dart
// Initialize the application
await Orchestrator.run(OrchestratorTaskType.initializeApp);

// Handle user authentication
await Orchestrator.run(OrchestratorTaskType.onAuthenticated);

// Respond to app lifecycle events
await Orchestrator.run(OrchestratorTaskType.onAppResumed);
```

### Logger Usage

The logger service provides consistent logging throughout the application:

```dart
// Get the logger instance
final logger = useLogger();

// Log at different levels
logger.d('Debug message');
logger.i('Information message');
logger.w('Warning message');
logger.e('Error message', error, stackTrace);

// Send troubleshooting data
await logger.sendTroubleshootMessage(
  topic: 'sync-issue',
  data: {'lastSyncTime': lastSyncTime.toIso8601String()},
);
```

### Performance Monitoring

Track performance of critical operations:

```dart
// Create a performance trace
final performance = usePerformance().create('operation-name');

// Start tracking
await performance.start();

// Perform operation
await performComplexOperation();

// Stop tracking
await performance.stop();
```

## Benefits

The infrastructure layer provides several key benefits:

1. **Separation of Concerns**: Isolates external dependencies from core business logic
2. **Centralized Configuration**: Provides a single point of configuration for external services
3. **Consistency**: Ensures consistent behavior across different app components
4. **Testability**: Makes it easier to mock external dependencies for testing
5. **Maintainability**: Centralizes integration code for easier updates and maintenance
6. **Performance Insights**: Provides tools for monitoring and optimizing application performance

By organizing these infrastructure components in a clean, structured way, the application maintains high cohesion within modules while minimizing coupling between them.