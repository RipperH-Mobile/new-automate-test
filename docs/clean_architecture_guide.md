# Clean Architecture Guide for UChat

## Table of Contents

1. [Overview](#overview)
2. [Project Structure](#project-structure)
3. [Layers](#layers)
   - [Data Layer](#data-layer)
   - [Domain Layer](#domain-layer)
   - [Presentation Layer](#presentation-layer)
4. [Flow of Control](#flow-of-control)
5. [Dependency Injection](#dependency-injection)
6. [Error Handling](#error-handling)
7. [Testing](#testing)
8. [Best Practices](#best-practices)

## Overview

UChat implements a partial Clean Architecture approach, organized in three primary layers:

- **Data**: Manages data sources, models, and repository implementations
- **Domain**: Defines entities, use cases, repositories interfaces, and services
- **Presentation**: Handles UI components, controllers, and state management

This architecture promotes:

- **Separation of concerns**: Each layer has a specific responsibility
- **Testability**: Components can be easily tested in isolation
- **Maintainability**: Changes in one layer minimize impact on others
- **Scalability**: Features can be developed independently

## Project Structure

The project follows a feature-first organization where each feature has its own directory with the three layers:

```
feature_name/
├── data/                                               # Data layer
│   ├── data_sources/
│   │   ├── local/
│   │   │   └── feature_name_local_datasource.dart
│   │   └── remote/
│   │       ├── feature_name_http_datasource.dart
│   │       └── feature_name_socket_datasource.dart
│   │
│   ├── models/
│   │   ├── payloads/
│   │   │   ├── create_feature_name_payload.dart
│   │   │   └── update_feature_name_payload.dart
│   │   └── collections/
│   │       └── feature_name_collection.dart
│   │
│   └── repositories/
│       └── feature_name_repository_impl.dart
│
├── di/
│   └── feature_injection.dart                      # Dependency injection
│
├── domain/                                         # Domain layer
│   ├── services/
│   │   └── feature_name_service.dart               # Stateful service
│   ├── entities/
│   │   └── feature_name_entity.dart
│   ├── enums/
│   │   └── feature_name_enum.dart
│   ├── events/
│   │   └── create_feature_name_events.dart
│   ├── exceptions/
│   │   ├── create_feature_name_exception.dart
│   │   └── update_feature_name_exception.dart
│   ├── repositories/
│   │   └── feature_name_repository.dart
│   ├── use_cases/                                  # Use cases
│   │   ├── get_feature_name_use_cases.dart
│   │   └── update_feature_name_use_cases.dart
│   └── typedefs.dart                               # typedefs
│
└── presentation/                                   # Presentation layer
    ├── arguments/
    │   └── feature_name_argument.dart
    ├── bindings/
    │   └── feature_name_binding.dart
    ├── controllers/
    │   └── feature_name_controller.dart
    ├── screens/
    │   └── feature_name_screen.dart
    └── widgets/
        ├── feature_name_item.dart
        └── feature_name_list.dart
```

## Layers

### Data Layer

The Data layer is responsible for retrieving and storing data from various sources.

**Key components:**

1. **Data Sources**: Define how to interact with specific data sources
   - **Local**: Database operations, local storage, cache, settings
   - **Remote**: API calls, WebSocket, push notifications, etc.

2. **Models**: Data transfer objects (DTOs) representing data structures
   - **Collections**: Database models
   - **Payloads**: Request/response models for API calls
   - All models should implement a `toEntity()` method to convert to domain entities

3. **Repository Implementations**: Implement repository interfaces from the Domain layer
   - Coordinate between multiple data sources
   - Transform data between models and entities using `toEntity()` methods
   - Handle data-specific errors

### Domain Layer

The Domain layer contains the core business logic of the application, independent of UI and data sources.

**Key components:**

1. **Entities**: Core business objects
   - Immutable data classes
   - Pure domain concepts without data layer dependencies

2. **Repositories**: Interfaces defining data access methods
   - Declared in domain, implemented in data layer
   - Define contracts for data operations

3. **Use Cases**: Encapsulate specific business operations
   - Single responsibility principle
   - Represent user interactions or system operations
   - Parameters defined within the use case file

4. **Services**: Stateful services for complex operations
   - Singleton instances
   - Can coordinate between multiple use cases
   - Maintain state and handle cross-feature operations

5. **Exceptions**: Domain-specific error types
   - Defined per feature for specific error cases

### Presentation Layer

The Presentation layer handles everything related to the UI, user interactions, and state management.

**Key components:**

1. **Screens**: Complete views shown to users
   - Compose widgets into full user interfaces
   - Minimal logic focused on layout and UI concerns

2. **Widgets**: Reusable UI components
   - Feature-specific widgets
   - Connect to controllers for state and logic

3. **Controllers**: Manage UI state and coordinate with domain layer
   - Execute use cases in response to UI events
   - Transform domain results to UI-friendly formats
   - Handle presentation-specific errors

4. **Bindings**: Connect dependencies to controllers
   - Initialize and provide dependencies
   - Connect controllers, use cases, repositories when a screen is loaded

5. **Arguments**: Data passed between screens
   - Define screen parameters
   - Encapsulate navigation data

## Flow of Control

The flow of data in the application follows a clear pattern:

1. **User Interaction**: User interacts with UI components in the Presentation layer
2. **Controller**: Handles the interaction and calls appropriate Use Case
3. **Use Case**: Executes business logic using Repository interfaces
4. **Repository Implementation**: Coordinates data operations between data sources
5. **Data Source**: Retrieves or stores data
6. **Return Path**: Data flows back through the same path
   - Data Source → Repository (transforms Models to Entities) → Use Case → Controller → UI

### Data Transformation Flow

When retrieving data from data sources, we follow this transformation process:

1. **Data Sources** return data as Models or Collections
2. **Repository** transforms models to entities using `toEntity()` methods
3. **Use Cases** receive and operate on entities only
4. **Controllers** receive entities and may transform them to presentation-specific formats

```
┌───────────────┐     ┌────────────────────┐     ┌───────────────┐
│  Data Source  │     │     Repository     │     │    Use Case   │
│               │     │                    │     │               │
│  returns      │────►│  transforms using  │────►│  operates on  │
│  Collection   │     │  toEntity()        │     │  Entity       │
└───────────────┘     └────────────────────┘     └───────────────┘
```

## Dependency Injection

Each feature has its own dependency injection to provide instances of its components:

1. **Feature Injection**: Defined in `feature_name/di/feature_injection.dart`
   - Register repositories, use cases, services, and controllers
   - Use `GetIt` to manage singleton and factory instances

2. **DI Initialization**: All features are initialized at app startup

Example:

```dart
void initChatInjection() {
  // Repositories
  getIt.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Use Cases
  getIt.registerFactory(
    () => SendMessageUseCase(repository: getIt()),
  );

  // Services
  getIt.registerLazySingleton<ChatService>(
    () => ChatServiceImpl(
      sendMessage: getIt(),
      getMessages: getIt(),
    ),
  );
}
```

## Error Handling

UChat uses direct exception throwing and handling instead of Either:

1. **Specific Exceptions**: Domain-specific exceptions are defined in the feature's domain layer
2. **Try-Catch Blocks**: Use try-catch for error handling in repositories and controllers
3. **Error Propagation**: Errors are caught and handled at appropriate levels
   - Data sources: Throw data-specific exceptions
   - Repositories: Catch data exceptions, transform to domain exceptions
   - Use Cases: Pass domain exceptions up the chain
   - Controllers: Catch and handle exceptions, update UI state accordingly

Example:

```dart
// Repository implementation
Future<void> sendMessage(MessageEntity message) async {
  try {
    final payload = MessagePayload.fromEntity(message);
    await remoteDataSource.sendMessage(payload);
  } on ApiException catch (e) {
    throw MessageSendFailedException(
      message: 'Failed to send message: ${e.message}',
      cause: e,
    );
  } on Exception catch (e) {
    throw MessageSendFailedException(
      message: 'Unexpected error while sending message',
      cause: e,
    );
  }
}

// Repository implementation for retrieving data
Future<List<MessageEntity>> getMessages(String roomId) async {
  try {
    final messageCollections = await localDataSource.getMessages(roomId);
    // Use toEntity() to transform data layer models to domain entities
    return messageCollections.map((collection) => collection.toEntity()).toList();
  } on DatabaseException catch (e) {
    throw MessageFetchFailedException(
      message: 'Failed to fetch messages: ${e.message}',
      cause: e,
    );
  }
}

// Controller
Future<void> sendMessage(String content) async {
  try {
    isLoading.value = true;
    final message = MessageEntity(
      content: content,
      senderId: currentUserId,
      timestamp: DateTime.now(),
    );
    await sendMessageUseCase(SendMessageParams(message: message));
    // Update UI state on success
  } on MessageSendFailedException catch (e) {
    // Handle specific error
    errorMessage.value = e.message;
  } catch (e) {
    // Handle unexpected error
    errorMessage.value = 'An unexpected error occurred';
  } finally {
    isLoading.value = false;
  }
}
```

## Testing

Testing follows the standard approach for Clean Architecture:

1. **Unit Tests**: Test each layer independently
   - **Data Layer**: Test repositories and data sources
   - **Domain Layer**: Test use cases and services
   - **Presentation Layer**: Test controllers

2. **Testing Patterns**:
   - Use mocks for dependencies
   - Test both success and error paths
   - Verify interactions between components

See [UNIT_TEST.md](./UNIT_TEST.md) for detailed testing guidelines.

## Best Practices

1. **Layer Independence**: Higher layers should not depend on lower layers
   - Domain layer should not import anything from data or presentation layers
   - Presentation layer can import from domain layer but not data layer

2. **Minimal Domain Entities**: Keep domain entities focused on business rules
   - No UI-specific properties
   - No serialization methods in entities

3. **Single Responsibility**: Each component should focus on one task
   - Use Cases should do one thing well
   - Repositories handle data coordination
   - Controllers manage UI state

4. **Naming Conventions**:
   - Use consistent naming across the architecture
   - Methods convey actions: `getUser()`, `saveMessage()`, etc.
   - Classes clearly indicate their role: `UserRepository`, `SendMessageUseCase`

5. **Tight Encapsulation**:
   - Keep implementation details hidden
   - Expose only what's needed through interfaces
   - Use private methods and properties liberally

6. **Error Handling**:
   - Define specific exceptions for each feature
   - Handle errors at the appropriate level
   - Provide clear error messages for debugging

7. **Data Transformation**:
   - Models in the data layer must implement `toEntity()` to transform to domain entities
   - Nested models should also implement `toEntity()` for proper conversion
   - For complex hierarchies, ensure all child models can convert to respective entities
   - Use this pattern consistently for clean separation between layers
   - Example: `MessageCollection.toEntity()` must handle all nested objects
   ```dart
   MessageEntity toEntity() {
     return MessageEntity(
       id: id ?? '',
       roomId: roomId ?? '',
       // Convert all nested models to entities
       files: files?.map((file) => file.toEntity()).toList(),
       meta: meta?.toEntity(),
       // Other properties...
     );
   }
   ```

8. **Testability**:
   - Design for 100% test coverage
   - Use dependency injection for easy mocking
   - Avoid static methods that can't be mocked