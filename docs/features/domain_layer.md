# Features - Domain Layer

## Overview

The Domain Layer is the core of Clean Architecture, containing the business logic and rules of the application. This layer is completely independent of the Data and Presentation layers, defining what the application does without concerning itself with how data is obtained or presented.

In UChat, the Domain Layer defines entities, repositories (interfaces), use cases, services, and business logic exceptions.

## Structure

Within each feature, the Domain Layer follows this structure:

```
feature_name/domain/
├── services/
│   └── feature_name_service.dart               # Stateful service for the feature, singleton
├── entities/
│   └── feature_name_entity.dart
├── enums/
│   └── feature_name_enum.dart
├── events/
│   └── create_feature_name_events.dart
├── exceptions/
│   ├── create_feature_name_exception.dart
│   └── update_feature_name_exception.dart
├── repositories/
│   └── feature_name_repository.dart
├── use_cases/                                  # Use cases for the feature, all used by get it factory
│   ├── get_feature_name_use_case.dart
│   └── update_feature_name_use_case.dart
└── typedefs.dart                               # typedefs for the feature
```

## Components

### Entities

Entities are the core business objects of the application. They are simple data classes that represent the most important concepts in the business domain.

Characteristics:
- Pure domain objects without data layer dependencies
- Immutable whenever possible
- Focus on business properties and behavior
- No serialization/deserialization methods

Example:

```dart
class UserEntity {
  final String id;
  final String displayName;
  final String? profileImage;
  final UserSettings settings;
  final DateTime lastSeen;
  final bool isOnline;

  const UserEntity({
    required this.id,
    required this.displayName,
    this.profileImage,
    required this.settings,
    required this.lastSeen,
    this.isOnline = false,
  });

  // Domain-specific behavior methods
  bool get isRecentlyActive => 
      DateTime.now().difference(lastSeen).inHours < 2;
  
  // For updating entity (keeping immutability)
  UserEntity copyWith({
    String? displayName,
    String? profileImage,
    UserSettings? settings,
    DateTime? lastSeen,
    bool? isOnline,
  }) {
    return UserEntity(
      id: this.id, // ID doesn't change
      displayName: displayName ?? this.displayName,
      profileImage: profileImage ?? this.profileImage,
      settings: settings ?? this.settings,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
```

### Repositories

Repositories define interfaces (contracts) for data operations. They describe what data operations are available without specifying how they are implemented.

Characteristics:
- Define methods for data access without implementation
- Use domain entities in signatures, not data models
- Use domain exceptions in contracts
- Focus on business operations, not technical details

Example:

```dart
abstract class UserRepository {
  // Get a user by ID
  Future<UserEntity> getUserProfile(String userId);

  // Update user profile information
  Future<void> updateUserProfile(UpdateUserProfileParams params);

  // Delete a user
  Future<void> deleteUser(String userId);

  // Check if a user exists
  Future<bool> userExists(String userId);
  
  // Subscribe to user online status changes
  Stream<UserEntity> getUserStatusUpdates(String userId);
}
```

### Use Cases

Use cases represent the actions that users can perform in the application. Each use case should have a single responsibility and execute one specific business operation.

Characteristics:
- Single responsibility principle
- Execute one business operation
- Use repositories for data access
- Return domain entities
- Define parameters in the same file

Example:

```dart
class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase({required this.repository});

  // call() makes the class callable
  Future<UserEntity> call(GetUserProfileParams params) async {
    if (params.userId.isEmpty) {
      throw UserProfileException(message: 'User ID cannot be empty');
    }
    
    try {
      return await repository.getUserProfile(params.userId);
    } catch (e) {
      // Rethrow domain exceptions directly
      if (e is UserProfileException) {
        rethrow;
      }
      
      // Wrap unexpected errors
      throw UserProfileException(
        message: 'Failed to get user profile',
        cause: e,
      );
    }
  }
}

// Parameters defined in the use case file
class GetUserProfileParams {
  final String userId;

  const GetUserProfileParams({required this.userId});
}
```

### Services

Services are stateful components that coordinate between use cases and provide domain-specific functionality that doesn't fit into a single use case.

Characteristics:
- Singleton instances
- Coordinate between multiple use cases
- Maintain state for the feature
- Handle cross-cutting concerns

Example:

```dart
class ChatService {
  final SendMessageUseCase sendMessage;
  final GetMessagesUseCase getMessages;
  final MarkMessageReadUseCase markMessageRead;
  
  // State for active conversations
  final Map<String, List<MessageEntity>> _activeConversations = {};
  
  ChatService({
    required this.sendMessage,
    required this.getMessages,
    required this.markMessageRead,
  });
  
  // Get cached messages first, then fetch from repository
  Future<List<MessageEntity>> loadConversation(String roomId) async {
    if (_activeConversations.containsKey(roomId)) {
      return _activeConversations[roomId]!;
    }
    
    final messages = await getMessages(GetMessagesParams(roomId: roomId));
    _activeConversations[roomId] = messages;
    return messages;
  }
  
  // Send a message and update local cache
  Future<void> sendMessageToRoom(String roomId, String content) async {
    final message = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      roomId: roomId,
      content: content,
      senderId: 'current-user-id', // In real app, get from user service
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
    );
    
    // Optimistically add to cache
    if (!_activeConversations.containsKey(roomId)) {
      _activeConversations[roomId] = [];
    }
    _activeConversations[roomId]!.add(message);
    
    // Send through use case
    try {
      await sendMessage(SendMessageParams(message: message));
      
      // Update status to sent
      final index = _activeConversations[roomId]!.indexWhere((m) => m.id == message.id);
      if (index >= 0) {
        final updatedMessage = message.copyWith(status: MessageStatus.sent);
        _activeConversations[roomId]![index] = updatedMessage;
      }
    } catch (e) {
      // Update status to failed
      final index = _activeConversations[roomId]!.indexWhere((m) => m.id == message.id);
      if (index >= 0) {
        final updatedMessage = message.copyWith(status: MessageStatus.failed);
        _activeConversations[roomId]![index] = updatedMessage;
      }
      
      rethrow; // Let the caller handle the exception
    }
  }
  
  // Clear the service state
  void clearCache() {
    _activeConversations.clear();
  }
}
```

### Exceptions

Domain-specific exceptions represent business rule violations or domain errors.

Characteristics:
- Specific to feature's domain concepts
- Independent of data or UI concerns
- Include meaningful messages
- Can contain additional context data

Example:

```dart
class UserProfileException implements Exception {
  final String message;
  final dynamic cause;

  UserProfileException({
    required this.message,
    this.cause,
  });

  @override
  String toString() => 'UserProfileException: $message';
}

class UserNotFoundException extends UserProfileException {
  final String userId;

  UserNotFoundException({
    required this.userId,
    dynamic cause,
  }) : super(
    message: 'User with ID $userId not found',
    cause: cause,
  );
}

class InvalidUserDataException extends UserProfileException {
  final Map<String, String> validationErrors;

  InvalidUserDataException({
    required this.validationErrors,
    dynamic cause,
  }) : super(
    message: 'Invalid user data: ${validationErrors.values.join(', ')}',
    cause: cause,
  );
}
```

### Events

Domain events represent significant occurrences in the domain that other parts of the application might be interested in.

Characteristics:
- Represent something that happened in the domain
- Used for cross-feature communication
- Named in past tense (e.g., UserCreated, MessageSent)

Example:

```dart
class MessageSentEvent {
  final MessageEntity message;
  final DateTime timestamp;

  MessageSentEvent({
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class UserStatusChangedEvent {
  final String userId;
  final bool isOnline;
  final DateTime timestamp;

  UserStatusChangedEvent({
    required this.userId,
    required this.isOnline,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
```

### Enums

Enums represent fixed sets of values in the domain.

Characteristics:
- Represent domain concepts with limited possible values
- Include helper methods for conversion

Example:

```dart
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed;
  
  factory MessageStatus.fromString(String value) {
    return MessageStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => MessageStatus.sent,
    );
  }
  
  String toValue() => name;
}

enum UserRole {
  admin,
  moderator,
  regular;
  
  bool get canManageRooms => this == UserRole.admin || this == UserRole.moderator;
  bool get canManageUsers => this == UserRole.admin;
  
  factory UserRole.fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => UserRole.regular,
    );
  }
}
```

### TypeDefs

TypeDefs provide type aliases for complex types used within the feature's domain.

Characteristics:
- Improve code readability
- Make complex types more understandable
- Group related type definitions

Example:

```dart
typedef UserId = String;
typedef RoomId = String;
typedef MessageId = String;

typedef UserMap = Map<UserId, UserEntity>;
typedef RoomMembersMap = Map<UserId, RoomMemberEntity>;

typedef UserProfileResult = Future<UserEntity>;
typedef MessagesList = List<MessageEntity>;

typedef OnMessageSent = Function(MessageEntity message);
typedef OnUserStatusChanged = Function(UserId userId, bool isOnline);
```

## Guidelines

### Entity Guidelines

1. **Immutability**:
   - Make entities immutable when possible
   - Use const constructors for entities without mutable state
   - Provide copyWith() methods for creating modified versions

2. **Focus on Domain Concepts**:
   - Include only properties relevant to the business domain
   - Avoid technical concerns like serialization
   - Include domain-specific validation and business rules

3. **Equality and Comparison**:
   - Implement proper equality (==) and hashCode for entities
   - Consider implementing comparable for sortable entities

4. **Documentation**:
   - Document the purpose of each entity
   - Explain complex business rules or validations

### Repository Guidelines

1. **Interface Design**:
   - Design clear, focused interfaces with specific methods
   - Use domain entities in method signatures
   - Return concrete types rather than dynamic

2. **Error Handling**:
   - Define which exceptions can be thrown
   - Use domain-specific exceptions, not data-layer exceptions

3. **Asynchronous Operations**:
   - Make operations that may take time asynchronous (Future/Stream)
   - Consider providing both one-time (Future) and continuous (Stream) data access methods

4. **Documentation**:
   - Document each method's purpose and behavior
   - Note any preconditions or side effects

### Use Case Guidelines

1. **Single Responsibility**:
   - Each use case should do exactly one thing
   - Break complex operations into multiple use cases

2. **Parameters**:
   - Define parameter classes within the use case file
   - Make parameter classes immutable (const constructors)
   - Validate parameters before proceeding

3. **Error Handling**:
   - Catch and transform unexpected errors
   - Allow domain exceptions to propagate
   - Add context to errors when useful

4. **Callable Classes**:
   - Implement the call() method to make use cases callable
   - This improves code readability when use cases are used

5. **Testing**:
   - Design use cases to be easily testable
   - Mock dependencies (repositories) for testing

### Service Guidelines

1. **State Management**:
   - Clearly document what state the service manages
   - Provide methods to reset/clear state when needed

2. **Dependency Injection**:
   - Inject use cases, not repositories
   - Avoid direct dependency on data layer components

3. **Event Broadcasting**:
   - Use events for cross-feature communication
   - Consider using a central event bus

4. **Thread Safety**:
   - Ensure services are thread-safe if used from multiple isolates
   - Use proper synchronization for shared state

5. **Documentation**:
   - Document service lifecycle
   - Explain coordination between use cases
   - Note any global state or shared resources

### Exception Guidelines

1. **Hierarchy**:
   - Create a base exception for each feature
   - Extend for specific error cases

2. **Information**:
   - Include all relevant information in exceptions
   - Provide access to the original cause when wrapping other exceptions

3. **Messages**:
   - Write clear, actionable error messages
   - Include context about what operation failed and why

4. **Testing**:
   - Test exception handling in use cases
   - Verify that the right exceptions are thrown in the right circumstances