# Features - Data Layer

## Overview

The Data Layer is responsible for retrieving and storing data from various sources. It serves as a bridge between external data sources (APIs, databases, caches, etc.) and the Domain Layer. This layer handles the technical details of data access while converting between external data formats and domain entities.

## Structure

Within each feature, the Data Layer follows this structure:

```
feature_name/data/
├── data_sources/
│   ├── local/
│   │   └── feature_name_local_datasource.dart
│   └── remote/
│       ├── feature_name_http_datasource.dart
│       └── feature_name_socket_datasource.dart
│
├── models/
│   ├── payloads/
│   │   ├── create_feature_name_payload.dart
│   │   └── update_feature_name_payload.dart
│   └── collections/
│       └── feature_name_collection.dart
│
└── repositories/
    └── feature_name_repository_impl.dart
```

## Components

### Data Sources

Data sources define interfaces for communicating with specific data providers.

#### Local Data Sources

Handle all local storage operations, including:
- Database access (collections)
- Shared preferences
- Local cache
- Files and assets

Example:

```dart
abstract class UserLocalDataSource {
  Future<UserCollection?> getUser(String id);
  Future<void> saveUser(UserCollection user);
  Future<void> deleteUser(String id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Database database;

  UserLocalDataSourceImpl({required this.database});

  @override
  Future<UserCollection?> getUser(String id) async {
    try {
      final doc = await database.users.doc(id).get();
      return doc.exists ? UserCollection.fromJson(doc.data()!) : null;
    } catch (e) {
      throw CacheException(message: 'Failed to get user: $e');
    }
  }

  // Other methods implementation
}
```

#### Remote Data Sources

Handle all network operations, including:
- REST API calls
- WebSockets
- Firebase services
- Push notifications

UChat typically divides remote data sources by protocol:
- HTTP Data Source: For REST API calls
- Socket Data Source: For WebSocket communications

Example:

```dart
abstract class UserRemoteDataSource {
  Future<UserPayload> getUserProfile(String id);
  Future<void> updateUserProfile(UpdateUserProfilePayload payload);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final HttpClient httpClient;
  final String baseUrl;

  UserRemoteDataSourceImpl({
    required this.httpClient,
    this.baseUrl = 'https://api.uchat.com',
  });

  @override
  Future<UserPayload> getUserProfile(String id) async {
    try {
      final response = await httpClient.get('$baseUrl/users/$id');
      
      if (response.statusCode == 200) {
        return UserPayload.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Failed to get user profile',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(
        message: 'Failed to get user profile: $e',
      );
    }
  }

  // Other methods implementation
}
```

### Models

Models are data structures that represent information from external sources, organized into two categories:

#### Collections

Collections represent data stored in databases:
- Correspond to database schemas
- Include serialization methods (toJson/fromJson)
- Used by local data sources

Example:

```dart
class UserCollection {
  final String id;
  final String displayName;
  final String? profileImage;
  final Map<String, dynamic> settings;
  final DateTime lastSeen;

  UserCollection({
    required this.id,
    required this.displayName,
    this.profileImage,
    required this.settings,
    required this.lastSeen,
  });

  // Serialization
  factory UserCollection.fromJson(Map<String, dynamic> json) {
    return UserCollection(
      id: json['id'],
      displayName: json['display_name'],
      profileImage: json['profile_image'],
      settings: json['settings'] ?? {},
      lastSeen: DateTime.parse(json['last_seen']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'profile_image': profileImage,
      'settings': settings,
      'last_seen': lastSeen.toIso8601String(),
    };
  }
  
  // Convert to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      displayName: displayName,
      profileImage: profileImage,
      settings: UserSettings.fromMap(settings),
      lastSeen: lastSeen,
    );
  }
}
```

#### Payloads

Payloads represent data sent to or received from APIs:
- Request payloads for API calls
- Response payloads from API responses
- Support serialization methods (toJson/fromJson)
- Used by remote data sources

Example:

```dart
class UpdateUserProfilePayload {
  final String displayName;
  final String? profileImage;
  final Map<String, dynamic>? settings;

  UpdateUserProfilePayload({
    required this.displayName,
    this.profileImage,
    this.settings,
  });

  // Create from domain entity
  factory UpdateUserProfilePayload.fromEntity(UpdateUserProfileParams params) {
    return UpdateUserProfilePayload(
      displayName: params.displayName,
      profileImage: params.profileImage,
      settings: params.settings?.toMap(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'display_name': displayName,
    };
    
    if (profileImage != null) {
      data['profile_image'] = profileImage;
    }
    
    if (settings != null) {
      data['settings'] = settings;
    }
    
    return data;
  }
}
```

### Repository Implementations

Repository implementations connect the data sources to the domain layer by:
- Implementing repository interfaces defined in the domain layer
- Coordinating between multiple data sources
- Converting between data models and domain entities
- Handling data layer exceptions and converting them to domain exceptions

Example:

```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> getUserProfile(String userId) async {
    try {
      // Try to get from local source first for faster loading
      final localUser = await localDataSource.getUser(userId);
      
      // If available locally and not stale, return it
      if (localUser != null && !_isStale(localUser.lastSeen)) {
        return localUser.toEntity();
      }
      
      // Otherwise fetch from remote
      final remoteUser = await remoteDataSource.getUserProfile(userId);
      
      // Save to local for future use
      await localDataSource.saveUser(UserCollection.fromPayload(remoteUser));
      
      // Return as domain entity
      return remoteUser.toEntity();
    } on CacheException catch (e) {
      // If cache fails but we can get remote, continue with remote only
      try {
        final remoteUser = await remoteDataSource.getUserProfile(userId);
        return remoteUser.toEntity();
      } catch (_) {
        throw UserProfileException(
          message: 'Failed to get user profile: ${e.message}',
          cause: e,
        );
      }
    } on ServerException catch (e) {
      throw UserProfileException(
        message: 'Failed to get user profile from server: ${e.message}',
        cause: e,
      );
    } catch (e) {
      throw UserProfileException(
        message: 'Unexpected error while getting user profile',
        cause: e,
      );
    }
  }

  // Helper method to check if local data is stale
  bool _isStale(DateTime lastUpdated) {
    final staleDuration = const Duration(hours: 1);
    return DateTime.now().difference(lastUpdated) > staleDuration;
  }

  // Other methods implementation
}
```

## Guidelines

### Data Source Guidelines

1. **Error Handling**:
   - Throw specific exceptions for each data source type
   - Include meaningful error messages with details
   - Pass original exception as cause when possible

2. **Data Validation**:
   - Validate incoming data before processing
   - Ensure all required fields are present
   - Check data types and formats

3. **Timeout Handling**:
   - Set appropriate timeouts for network operations
   - Implement retry mechanisms for transient failures
   - Return cached data during network failures when possible

4. **Authentication**:
   - Handle authentication tokens and refreshing
   - Securely store credentials
   - Clear sensitive data when logging out

### Model Guidelines

1. **Serialization**:
   - Implement proper serialization methods (toJson/fromJson)
   - Handle nullable fields appropriately
   - Validate incoming JSON data

2. **Entity Conversion**:
   - Provide methods to convert between models and entities
   - Handle missing fields gracefully
   - Preserve all necessary data during conversion

3. **Naming Convention**:
   - Append "Collection" to database models
   - Append "Payload" to API request/response models
   - Use descriptive names for specific payloads (e.g., "UpdateUserProfilePayload")

### Repository Guidelines

1. **Interface Adherence**:
   - Strictly follow the interface defined in the domain layer
   - Don't expose data source details to domain layer

2. **Data Source Coordination**:
   - Implement caching strategies (cache-then-network, network-then-cache)
   - Sync data between local and remote sources
   - Handle conflicts between data sources

3. **Error Transformation**:
   - Convert data-specific exceptions to domain-specific exceptions
   - Preserve original error information when possible
   - Add context to error messages

4. **Testing**:
   - Mock data sources for testing repositories
   - Test both success and failure paths
   - Test caching strategies and data source coordination