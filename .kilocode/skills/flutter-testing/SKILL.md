---
name: flutter-testing
description: Generate comprehensive tests for Flutter applications using Mocktail and Given-When-Then pattern. Use this skill when creating unit tests, integration tests, or ensuring 100% test coverage in the UChat Messenger project.
include: always
---

# Flutter Testing Skill

## Overview

This skill provides comprehensive guidance for creating tests in the UChat Messenger Flutter project. The project mandates **100% test coverage** using **Mocktail** and the **Given-When-Then** pattern. Tests mirror the source code structure and cover all layers of the Clean Architecture.

## Testing Philosophy

The UChat Messenger project follows these testing principles:

- **100% Coverage**: All production code must have corresponding tests
- **Mocktail Framework**: Use Mocktail for all mocking needs (no Mockito)
- **Given-When-Then Pattern**: Structure tests with clear setup, action, and assertion phases
- **Mirror Structure**: Test files mirror source code paths for easy navigation
- **Layer Isolation**: Test each layer independently with appropriate mocks
- **GetX Compatibility**: Tests work seamlessly with GetX state management
- **Isar Testing**: Database tests use in-memory instances for speed and isolation

## Test Structure

### Directory Organization

Tests mirror the source code structure:

```
test/
├── core/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── user_test.dart
│   │   ├── usecases/
│   │   │   └── get_user_test.dart
│   │   └── repositories/
│   │       └── user_repository_test.dart
│   ├── data/
│   │   ├── repositories/
│   │   │   └── user_repository_impl_test.dart
│   │   ├── datasources/
│   │   │   ├── user_local_datasource_test.dart
│   │   │   └── user_remote_datasource_test.dart
│   │   └── models/
│   │       └── user_model_test.dart
│   ├── presentation/
│   │   ├── controllers/
│   │   │   └── user_controller_test.dart
│   │   └── widgets/
│   │       └── user_widget_test.dart
│   └── infrastructure/
│       ├── database/
│       │   └── isar_database_test.dart
│       └── api/
│           └── api_client_test.dart
└── features/
    └── chat/
        ├── domain/
        ├── data/
        └── presentation/
```

### Naming Conventions

- Test files: `{source_file}_test.dart`
- Test classes: `{ClassName}Test`
- Test methods: `describe_{what_is_being_tested}_when_{condition}_then_{expected_result}`

## Mocktail Mock Generation

### Creating Mocks

Mocktail generates mocks automatically. Use the `@GenerateMocks` annotation or create mocks manually:

```dart
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockUserController extends Mock implements UserController {}
```

### Mock Setup and Configuration

Configure mock behaviors in the `Given` phase:

```dart
// Simple return value
when(() => mockUserRepository.getUser('123'))
    .thenReturn(User(id: '123', name: 'John'));

// Async return value
when(() => mockUserRepository.getUserAsync('123'))
    .thenAnswer((_) async => User(id: '123', name: 'John'));

// Throwing exceptions
when(() => mockUserRepository.getUser('invalid'))
    .thenThrow(UserNotFoundException());

// Multiple calls with different values
when(() => mockUserRepository.getUser(any()))
    .thenAnswer((invocation) {
      final id = invocation.positionalArguments[0] as String;
      return User(id: id, name: 'User $id');
    });

// Capturing arguments
when(() => mockUserRepository.saveUser(captureAny()))
    .thenAnswer((_) async => true);
```

### Common Mock Patterns

#### Repository Mocks

```dart
class MockUserRepository extends Mock implements UserRepository {}

void setupMockRepository() {
  // Success case
  when(() => mockRepository.getUser('123'))
      .thenReturn(User(id: '123', name: 'John'));

  // Not found case
  when(() => mockRepository.getUser('404'))
      .thenThrow(UserNotFoundException());

  // Network error
  when(() => mockRepository.getUser('500'))
      .thenThrow(NetworkException());
}
```

#### Data Source Mocks

```dart
class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void setupMockDataSource() {
  when(() => mockDataSource.fetchUser('123'))
      .thenReturn(UserModel.fromJson({
        'id': '123',
        'name': 'John',
      }));

  when(() => mockDataSource.fetchUser(any()))
      .thenThrow(ServerException());
}
```

#### Use Case Mocks

```dart
class MockGetUserUseCase extends Mock implements GetUserUseCase {}

void setupMockUseCase() {
  when(() => mockUseCase.call('123'))
      .thenReturn(Right(User(id: '123', name: 'John')));

  when(() => mockUseCase.call('invalid'))
      .thenReturn(Left(UserNotFoundFailure()));
}
```

#### Controller Mocks

```dart
class MockUserController extends Mock implements UserController {}

void setupMockController() {
  when(() => mockController.isLoading)
      .thenReturn(false.obs);

  when(() => mockController.user)
      .thenReturn(User(id: '123', name: 'John').obs);
}
```

### Verification

Verify mock interactions in the `Then` phase:

```dart
// Verify method was called
verify(() => mockRepository.getUser('123')).called(1);

// Verify method was never called
verifyNever(() => mockRepository.deleteUser('123'));

// Verify with specific arguments
verify(() => mockRepository.saveUser(argThat(isA<User>()))).called(1);

// Verify exact number of calls
verify(() => mockRepository.getUser('123')).called(greaterThan(0));

// Capture arguments
final captured = verify(() => mockRepository.saveUser(captureAny())).captured;
expect(captured.first, isA<User>());
```

## Given-When-Then Pattern

### Pattern Overview

The Given-When-Then pattern structures tests into three clear phases:

- **Given**: Set up the test scenario, create mocks, initialize state
- **When**: Perform the action being tested
- **Then**: Assert the expected outcome

### Test Template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late UserRepository mockRepository;
  late GetUserUseCase useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCase(mockRepository);
  });

  group('GetUserUseCase', () {
    test('should return user when repository returns user', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John');
      when(() => mockRepository.getUser(userId))
          .thenReturn(expectedUser);

      // When
      final result = await useCase(userId);

      // Then
      expect(result, equals(expectedUser));
      verify(() => mockRepository.getUser(userId)).called(1);
    });

    test('should throw exception when repository throws', () async {
      // Given
      const userId = 'invalid';
      when(() => mockRepository.getUser(userId))
          .thenThrow(UserNotFoundException());

      // When & Then
      expect(
        () => useCase(userId),
        throwsA(isA<UserNotFoundException>()),
      );
    });
  });
}
```

### Best Practices

1. **Clear Separation**: Keep Given, When, Then sections distinct
2. **Descriptive Names**: Test names should describe the scenario
3. **Single Responsibility**: Each test should verify one behavior
4. **Arrange in Given**: All setup goes in the Given phase
5. **One Action in When**: Perform only one action in the When phase
6. **Multiple Assertions in Then**: Group related assertions in Then

## Test Templates for Each Layer

### Domain Layer Tests

#### Entity Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Entity', () {
    test('should create user with valid parameters', () {
      // Given
      const id = '123';
      const name = 'John Doe';

      // When
      final user = User(id: id, name: name);

      // Then
      expect(user.id, equals(id));
      expect(user.name, equals(name));
    });

    test('should implement equality correctly', () {
      // Given
      const user1 = User(id: '123', name: 'John');
      const user2 = User(id: '123', name: 'John');
      const user3 = User(id: '456', name: 'Jane');

      // When & Then
      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
    });

    test('should implement props correctly for Equatable', () {
      // Given
      const user1 = User(id: '123', name: 'John');
      const user2 = User(id: '123', name: 'John');

      // When & Then
      expect(user1.props, equals(user2.props));
    });
  });
}
```

#### Use Case Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockRepository;
  late GetUserUseCase useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCase(mockRepository);
  });

  group('GetUserUseCase', () {
    test('should return user from repository', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John');
      when(() => mockRepository.getUser(userId))
          .thenReturn(expectedUser);

      // When
      final result = await useCase(userId);

      // Then
      expect(result, equals(expectedUser));
      verify(() => mockRepository.getUser(userId)).called(1);
    });

    test('should cache user after successful retrieval', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John');
      when(() => mockRepository.getUser(userId))
          .thenReturn(expectedUser);

      // When
      await useCase(userId);
      final cachedUser = await useCase(userId);

      // Then
      expect(cachedUser, equals(expectedUser));
      verify(() => mockRepository.getUser(userId)).called(1);
    });

    test('should throw NotFoundException when user not found', () async {
      // Given
      const userId = 'invalid';
      when(() => mockRepository.getUser(userId))
          .thenThrow(UserNotFoundException());

      // When & Then
      expect(
        () => useCase(userId),
        throwsA(isA<UserNotFoundException>()),
      );
    });
  });
}
```

#### Repository Interface Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserRepository Interface', () {
    test('should define getUser method', () {
      // Given
      final repository = UserRepositoryImpl();

      // When & Then
      expect(repository, isA<UserRepository>());
    });

    test('should define saveUser method', () {
      // Given
      final repository = UserRepositoryImpl();

      // When & Then
      expect(repository, isA<UserRepository>());
    });
  });
}
```

### Data Layer Tests

#### Repository Implementation Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('UserRepositoryImpl', () {
    test('should get user from remote data source', () async {
      // Given
      const userId = '123';
      const userModel = UserModel(id: userId, name: 'John');
      const expectedUser = User(id: userId, name: 'John');
      when(() => mockRemoteDataSource.fetchUser(userId))
          .thenReturn(userModel);

      // When
      final result = await repository.getUser(userId);

      // Then
      expect(result, equals(expectedUser));
      verify(() => mockRemoteDataSource.fetchUser(userId)).called(1);
    });

    test('should cache user locally after remote fetch', () async {
      // Given
      const userId = '123';
      const userModel = UserModel(id: userId, name: 'John');
      when(() => mockRemoteDataSource.fetchUser(userId))
          .thenReturn(userModel);
      when(() => mockLocalDataSource.cacheUser(userModel))
          .thenAnswer((_) async => Future.value());

      // When
      await repository.getUser(userId);

      // Then
      verify(() => mockLocalDataSource.cacheUser(userModel)).called(1);
    });

    test('should throw ServerException when remote fails', () async {
      // Given
      const userId = 'invalid';
      when(() => mockRemoteDataSource.fetchUser(userId))
          .thenThrow(ServerException());

      // When & Then
      expect(
        () => repository.getUser(userId),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
```

#### Data Source Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSource dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSource(client: mockHttpClient);
  });

  group('UserRemoteDataSource', () {
    test('should return UserModel when response is 200', () async {
      // Given
      const userId = '123';
      final response = http.Response('{"id":"123","name":"John"}', 200);
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => response);

      // When
      final result = await dataSource.fetchUser(userId);

      // Then
      expect(result, isA<UserModel>());
      expect(result.id, equals(userId));
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should throw ServerException when response is 404', () async {
      // Given
      const userId = 'invalid';
      final response = http.Response('Not Found', 404);
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => response);

      // When & Then
      expect(
        () => dataSource.fetchUser(userId),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when response is 500', () async {
      // Given
      const userId = '123';
      final response = http.Response('Server Error', 500);
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => response);

      // When & Then
      expect(
        () => dataSource.fetchUser(userId),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
```

#### Model Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('should create UserModel from JSON', () {
      // Given
      final json = {
        'id': '123',
        'name': 'John Doe',
        'email': 'john@example.com',
      };

      // When
      final model = UserModel.fromJson(json);

      // Then
      expect(model.id, equals('123'));
      expect(model.name, equals('John Doe'));
      expect(model.email, equals('john@example.com'));
    });

    test('should convert to JSON', () {
      // Given
      const model = UserModel(
        id: '123',
        name: 'John Doe',
        email: 'john@example.com',
      );

      // When
      final json = model.toJson();

      // Then
      expect(json['id'], equals('123'));
      expect(json['name'], equals('John Doe'));
      expect(json['email'], equals('john@example.com'));
    });

    test('should convert to Entity', () {
      // Given
      const model = UserModel(
        id: '123',
        name: 'John Doe',
        email: 'john@example.com',
      );

      // When
      final entity = model.toEntity();

      // Then
      expect(entity, isA<User>());
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
    });

    test('should handle Thai characters correctly', () {
      // Given
      final json = {
        'id': '123',
        'name': 'สวัสดี ครับ',
        'email': 'test@example.com',
      };

      // When
      final model = UserModel.fromJson(json);

      // Then
      expect(model.name, equals('สวัสดี ครับ'));
    });
  });
}
```

### Presentation Layer Tests

#### GetX Controller Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

void main() {
  late MockGetUserUseCase mockUseCase;
  late UserController controller;

  setUp(() {
    mockUseCase = MockGetUserUseCase();
    Get.testMode = true;
    controller = UserController(useCase: mockUseCase);
  });

  tearDown(() {
    Get.reset();
  });

  group('UserController', () {
    test('should initialize with empty user', () {
      // Given & When
      final user = controller.user;

      // Then
      expect(user.value, isNull);
    });

    test('should load user successfully', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John');
      when(() => mockUseCase(userId))
          .thenReturn(expectedUser);

      // When
      await controller.loadUser(userId);

      // Then
      expect(controller.user.value, equals(expectedUser));
      expect(controller.isLoading.value, isFalse);
      verify(() => mockUseCase(userId)).called(1);
    });

    test('should set loading state during fetch', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John');
      when(() => mockUseCase(userId))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return expectedUser;
      });

      // When
      final loadFuture = controller.loadUser(userId);
      expect(controller.isLoading.value, isTrue);
      await loadFuture;

      // Then
      expect(controller.isLoading.value, isFalse);
    });

    test('should handle error when loading user', () async {
      // Given
      const userId = 'invalid';
      when(() => mockUseCase(userId))
          .thenThrow(UserNotFoundException());

      // When
      await controller.loadUser(userId);

      // Then
      expect(controller.user.value, isNull);
      expect(controller.errorMessage.value, isNotEmpty);
      expect(controller.isLoading.value, isFalse);
    });

    test('should clear error message', () {
      // Given
      controller.errorMessage.value = 'Error';

      // When
      controller.clearError();

      // Then
      expect(controller.errorMessage.value, isEmpty);
    });
  });
}
```

#### Widget Tests

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

class MockUserController extends Mock implements UserController {}

void main() {
  late MockUserController mockController;

  setUp(() {
    mockController = MockUserController();
    Get.testMode = true;
    Get.put<UserController>(mockController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('should display user name when user is loaded',
      (WidgetTester tester) async {
    // Given
    const user = User(id: '123', name: 'John Doe');
    when(() => mockController.user).thenReturn(user.obs);
    when(() => mockController.isLoading).thenReturn(false.obs);

    // When
    await tester.pumpWidget(
      GetMaterialApp(
        home: UserScreen(),
      ),
    );

    // Then
    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets('should show loading indicator when loading',
      (WidgetTester tester) async {
    // Given
    when(() => mockController.user).thenReturn(Rx<User?>(null));
    when(() => mockController.isLoading).thenReturn(true.obs);

    // When
    await tester.pumpWidget(
      GetMaterialApp(
        home: UserScreen(),
      ),
    );

    // Then
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message when error occurs',
      (WidgetTester tester) async {
    // Given
    when(() => mockController.user).thenReturn(Rx<User?>(null));
    when(() => mockController.isLoading).thenReturn(false.obs);
    when(() => mockController.errorMessage)
        .thenReturn('Failed to load user'.obs);

    // When
    await tester.pumpWidget(
      GetMaterialApp(
        home: UserScreen(),
      ),
    );

    // Then
    expect(find.text('Failed to load user'), findsOneWidget);
  });

  testWidgets('should call loadUser when button is tapped',
      (WidgetTester tester) async {
    // Given
    when(() => mockController.user).thenReturn(Rx<User?>(null));
    when(() => mockController.isLoading).thenReturn(false.obs);
    when(() => mockController.loadUser(any())).thenAnswer((_) async {});

    // When
    await tester.pumpWidget(
      GetMaterialApp(
        home: UserScreen(),
      ),
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Then
    verify(() => mockController.loadUser(any())).called(1);
  });

  testWidgets('should support Thai text rendering',
      (WidgetTester tester) async {
    // Given
    const user = User(id: '123', name: 'สวัสดี ครับ');
    when(() => mockController.user).thenReturn(user.obs);
    when(() => mockController.isLoading).thenReturn(false.obs);

    // When
    await tester.pumpWidget(
      GetMaterialApp(
        home: UserScreen(),
      ),
    );

    // Then
    expect(find.text('สวัสดี ครับ'), findsOneWidget);
  });
}
```

### Infrastructure Tests

#### Isar Database Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  late Isar isar;

  setUp(() async {
    final dir = await getTemporaryDirectory();
    isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
      name: 'test_${DateTime.now().millisecondsSinceEpoch}',
    );
  });

  tearDown(() async {
    await isar.close();
  });

  group('Isar Database', () {
    test('should save user to database', () async {
      // Given
      const user = User()
        ..id = '123'
        ..name = 'John Doe';

      // When
      await isar.writeTxn(() async {
        await isar.users.put(user);
      });

      // Then
      final savedUser = await isar.users.get('123');
      expect(savedUser?.name, equals('John Doe'));
    });

    test('should retrieve user by id', () async {
      // Given
      const user = User()
        ..id = '123'
        ..name = 'John Doe';
      await isar.writeTxn(() async {
        await isar.users.put(user);
      });

      // When
      final retrievedUser = await isar.users.get('123');

      // Then
      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.name, equals('John Doe'));
    });

    test('should update existing user', () async {
      // Given
      const user = User()
        ..id = '123'
        ..name = 'John Doe';
      await isar.writeTxn(() async {
        await isar.users.put(user);
      });

      // When
      await isar.writeTxn(() async {
        await isar.users.put(User()
          ..id = '123'
          ..name = 'Jane Doe');
      });

      // Then
      final updatedUser = await isar.users.get('123');
      expect(updatedUser?.name, equals('Jane Doe'));
    });

    test('should delete user from database', () async {
      // Given
      const user = User()
        ..id = '123'
        ..name = 'John Doe';
      await isar.writeTxn(() async {
        await isar.users.put(user);
      });

      // When
      await isar.writeTxn(() async {
        await isar.users.delete('123');
      });

      // Then
      final deletedUser = await isar.users.get('123');
      expect(deletedUser, isNull);
    });

    test('should query users by name', () async {
      // Given
      await isar.writeTxn(() async {
        await isar.users.putAll([
          User()..id = '1'..name = 'John Doe',
          User()..id = '2'..name = 'Jane Doe',
          User()..id = '3'..name = 'Bob Smith',
        ]);
      });

      // When
      final users = await isar.users
          .where()
          .nameContains('Doe')
          .findAll();

      // Then
      expect(users.length, equals(2));
    });
  });
}
```

#### API Client Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late ApiClient apiClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = ApiClient(client: mockHttpClient);
  });

  group('ApiClient', () {
    test('should make GET request and return response', () async {
      // Given
      const endpoint = '/users/123';
      final response = http.Response('{"id":"123","name":"John"}', 200);
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => response);

      // When
      final result = await apiClient.get(endpoint);

      // Then
      expect(result.statusCode, equals(200));
      expect(result.body, contains('John'));
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should make POST request with body', () async {
      // Given
      const endpoint = '/users';
      final body = {'name': 'John', 'email': 'john@example.com'};
      final response = http.Response('{"id":"123"}', 201);
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => response);

      // When
      final result = await apiClient.post(endpoint, body: body);

      // Then
      expect(result.statusCode, equals(201));
      verify(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .called(1);
    });

    test('should handle network errors', () async {
      // Given
      const endpoint = '/users/123';
      when(() => mockHttpClient.get(any()))
          .thenThrow(http.ClientException('Network error'));

      // When & Then
      expect(
        () => apiClient.get(endpoint),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
```

## GetX Controller Testing

### Testing Reactive State (Rx Observables)

```dart
test('should update user value when loadUser succeeds', () async {
  // Given
  const userId = '123';
  const expectedUser = User(id: userId, name: 'John');
  when(() => mockUseCase(userId)).thenReturn(expectedUser);

  // When
  await controller.loadUser(userId);

  // Then
  expect(controller.user.value, equals(expectedUser));
});

test('should update isLoading value during fetch', () async {
  // Given
  const userId = '123';
  when(() => mockUseCase(userId)).thenAnswer((_) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return User(id: userId, name: 'John');
  });

  // When
  final loadFuture = controller.loadUser(userId);

  // Then - loading should be true during fetch
  expect(controller.isLoading.value, isTrue);
  await loadFuture;
  expect(controller.isLoading.value, isFalse);
});
```

### Testing Worker Methods

```dart
test('should call refresh when user changes', () async {
  // Given
  when(() => mockUseCase.refresh()).thenAnswer((_) async {});

  // When
  controller.user.value = User(id: '123', name: 'John');
  await controller.onInit();

  // Then
  verify(() => mockUseCase.refresh()).called(1);
});

test('should debounce search input', () async {
  // Given
  when(() => mockUseCase.search(any())).thenReturn([]);

  // When
  controller.searchQuery.value = 'test';
  controller.searchQuery.value = 'testing';
  await Future.delayed(const Duration(milliseconds: 500));

  // Then
  verify(() => mockUseCase.search('testing')).called(1);
  verifyNever(() => mockUseCase.search('test'));
});
```

### Testing Controller Lifecycle

```dart
test('should initialize user on onInit', () async {
  // Given
  const userId = '123';
  const expectedUser = User(id: userId, name: 'John');
  when(() => mockUseCase(userId)).thenReturn(expectedUser);

  // When
  controller.onInit();

  // Then
  expect(controller.user.value, equals(expectedUser));
});

test('should dispose resources on onClose', () {
  // Given
  controller.onInit();

  // When
  controller.onClose();

  // Then
  expect(() => controller.user.value, throwsA(isA<StateError>()));
});
```

## Isar Database Testing

### Setting Up In-Memory Isar

```dart
late Isar isar;

setUp(() async {
  final dir = await getTemporaryDirectory();
  isar = await Isar.open(
    [UserSchema, MessageSchema],
    directory: dir.path,
    name: 'test_${DateTime.now().millisecondsSinceEpoch}',
  );
});

tearDown(() async {
  await isar.close();
});
```

### Testing CRUD Operations

```dart
test('should create and read user', () async {
  // Given
  const user = User()
    ..id = '123'
    ..name = 'John Doe';

  // When
  await isar.writeTxn(() async {
    await isar.users.put(user);
  });
  final result = await isar.users.get('123');

  // Then
  expect(result?.name, equals('John Doe'));
});

test('should update user', () async {
  // Given
  const user = User()
    ..id = '123'
    ..name = 'John Doe';
  await isar.writeTxn(() async {
    await isar.users.put(user);
  });

  // When
  await isar.writeTxn(() async {
    await isar.users.put(User()
      ..id = '123'
      ..name = 'Jane Doe');
  });

  // Then
  final result = await isar.users.get('123');
  expect(result?.name, equals('Jane Doe'));
});

test('should delete user', () async {
  // Given
  const user = User()
    ..id = '123'
    ..name = 'John Doe';
  await isar.writeTxn(() async {
    await isar.users.put(user);
  });

  // When
  await isar.writeTxn(() async {
    await isar.users.delete('123');
  });

  // Then
  final result = await isar.users.get('123');
  expect(result, isNull);
});
```

### Testing Queries and Filters

```dart
test('should query users by name', () async {
  // Given
  await isar.writeTxn(() async {
    await isar.users.putAll([
      User()..id = '1'..name = 'John Doe',
      User()..id = '2'..name = 'Jane Doe',
      User()..id = '3'..name = 'Bob Smith',
    ]);
  });

  // When
  final users = await isar.users
      .where()
      .nameContains('Doe')
      .findAll();

  // Then
  expect(users.length, equals(2));
});

test('should sort users by name', () async {
  // Given
  await isar.writeTxn(() async {
    await isar.users.putAll([
      User()..id = '1'..name = 'Charlie',
      User()..id = '2'..name = 'Alice',
      User()..id = '3'..name = 'Bob',
    ]);
  });

  // When
  final users = await isar.users.where().sortByName().findAll();

  // Then
  expect(users[0].name, equals('Alice'));
  expect(users[1].name, equals('Bob'));
  expect(users[2].name, equals('Charlie'));
});
```

## Widget Testing

### Testing with pumpWidget

```dart
testWidgets('should render UserScreen', (WidgetTester tester) async {
  // Given
  when(() => mockController.user).thenReturn(User(id: '123', name: 'John').obs);
  when(() => mockController.isLoading).thenReturn(false.obs);

  // When
  await tester.pumpWidget(
    GetMaterialApp(
      home: UserScreen(),
    ),
  );

  // Then
  expect(find.byType(UserScreen), findsOneWidget);
});
```

### Testing Widget Interactions

```dart
testWidgets('should call loadUser when button tapped',
    (WidgetTester tester) async {
  // Given
  when(() => mockController.user).thenReturn(Rx<User?>(null));
  when(() => mockController.isLoading).thenReturn(false.obs);
  when(() => mockController.loadUser(any())).thenAnswer((_) async {});

  // When
  await tester.pumpWidget(
    GetMaterialApp(
      home: UserScreen(),
    ),
  );
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();

  // Then
  verify(() => mockController.loadUser(any())).called(1);
});

testWidgets('should update text field when user types',
    (WidgetTester tester) async {
  // Given
  when(() => mockController.searchQuery).thenReturn(''.obs);

  // When
  await tester.pumpWidget(
    GetMaterialApp(
      home: SearchScreen(),
    ),
  );
  await tester.enterText(find.byType(TextField), 'search term');

  // Then
  expect(find.text('search term'), findsOneWidget);
});
```

### Testing GetX Reactive Widgets

```dart
testWidgets('should update Obx widget when user changes',
    (WidgetTester tester) async {
  // Given
  final user = User(id: '123', name: 'John').obs;
  when(() => mockController.user).thenReturn(user);
  when(() => mockController.isLoading).thenReturn(false.obs);

  // When
  await tester.pumpWidget(
    GetMaterialApp(
      home: UserScreen(),
    ),
  );
  user.value = User(id: '123', name: 'Jane');
  await tester.pump();

  // Then
  expect(find.text('Jane'), findsOneWidget);
  expect(find.text('John'), findsNothing);
});
```

## Integration Testing

### Setting Up Integration Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('complete user login flow', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(MyApp());

    // When
    await tester.enterText(find.byKey(Key('email_field')), 'test@example.com');
    await tester.enterText(find.byKey(Key('password_field')), 'password123');
    await tester.tap(find.byKey(Key('login_button')));
    await tester.pumpAndSettle();

    // Then
    expect(find.text('Welcome'), findsOneWidget);
  });
}
```

### Testing Navigation with GetX

```dart
testWidgets('should navigate to user details when tapped',
    (WidgetTester tester) async {
  // Given
  Get.testMode = true;
  await tester.pumpWidget(
    GetMaterialApp(
      home: UserListScreen(),
      getPages: [
        GetPage(name: '/', page: () => UserListScreen()),
        GetPage(name: '/user/:id', page: () => UserDetailScreen()),
      ],
    ),
  );

  // When
  await tester.tap(find.text('John Doe'));
  await tester.pumpAndSettle();

  // Then
  expect(Get.currentRoute, equals('/user/123'));
});
```

## Coverage Analysis

### Running Coverage Reports

```bash
# Run all tests with coverage
fvm flutter test --coverage

# Generate coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
open coverage/html/index.html
```

### Identifying Untested Code

```bash
# Run coverage and check for gaps
fvm flutter test --coverage

# View coverage summary
lcov --summary coverage/lcov.info
```

### Coverage Thresholds

The project requires:
- **100% line coverage** for all production code
- **100% branch coverage** for all conditional logic
- **100% function coverage** for all public methods

## Best Practices

### Test Isolation

Each test should be independent:

```dart
test('should not affect other tests', () async {
  // Given - fresh setup for each test
  final user = User(id: '123', name: 'John');

  // When
  await repository.save(user);

  // Then - only verify this test's behavior
  expect(await repository.get('123'), equals(user));
});
```

### Descriptive Test Names

```dart
// Good
test('should return user when repository returns user', () async {});

// Bad
test('test user', () async {});
```

### One Assertion Per Test

```dart
// Good
test('should set loading state to true', () async {
  expect(controller.isLoading.value, isTrue);
});

test('should clear user on error', () async {
  expect(controller.user.value, isNull);
});

// Bad
test('should handle loading and error', () async {
  expect(controller.isLoading.value, isTrue);
  expect(controller.user.value, isNull);
});
```

### Use Test Groups

```dart
group('UserRepository', () {
  group('getUser', () {
    test('should return user when found', () async {});
    test('should throw when not found', () async {});
  });

  group('saveUser', () {
    test('should save user successfully', () async {});
    test('should throw on validation error', () async {});
  });
});
```

## Common Testing Patterns

### Testing Async Operations

```dart
test('should handle async operation', () async {
  // Given
  when(() => mockRepository.getUser('123'))
      .thenAnswer((_) async => User(id: '123', name: 'John'));

  // When
  final result = await repository.getUser('123');

  // Then
  expect(result, isA<User>());
});
```

### Testing Error Scenarios

```dart
test('should handle network error', () async {
  // Given
  when(() => mockRepository.getUser('123'))
      .thenThrow(NetworkException());

  // When & Then
  expect(
    () => repository.getUser('123'),
    throwsA(isA<NetworkException>()),
  );
});
```

### Testing Loading States

```dart
test('should show loading indicator', () async {
  // Given
  when(() => mockController.isLoading).thenReturn(true.obs);

  // When
  await tester.pumpWidget(GetMaterialApp(home: UserScreen()));

  // Then
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

### Testing Pagination

```dart
test('should load next page when scrolling', () async {
  // Given
  when(() => mockController.loadNextPage()).thenAnswer((_) async {});

  // When
  await tester.pumpWidget(GetMaterialApp(home: UserListScreen()));
  await tester.drag(find.byType(Scrollable), const Offset(0, -500));
  await tester.pump();

  // Then
  verify(() => mockController.loadNextPage()).called(1);
});
```

## Development Commands

### Running Tests

```bash
# Run all tests
fvm flutter test

# Run specific test file
fvm flutter test test/core/domain/entities/user_test.dart

# Run with coverage
fvm flutter test --coverage

# Run specific test by name
fvm flutter test --name "should return user when repository returns user"

# Run tests in watch mode
fvm flutter test --watch

# Run tests with verbose output
fvm flutter test --verbose

# Run tests for specific platform
fvm flutter test --platform chrome
```

## Complete Examples

### Unit Test Example for Use Case

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockRepository;
  late GetUserUseCase useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCase(mockRepository);
  });

  group('GetUserUseCase', () {
    test('should return user when repository returns user', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John Doe');
      when(() => mockRepository.getUser(userId))
          .thenReturn(expectedUser);

      // When
      final result = await useCase(userId);

      // Then
      expect(result, equals(expectedUser));
      verify(() => mockRepository.getUser(userId)).called(1);
    });

    test('should throw UserNotFoundException when user not found', () async {
      // Given
      const userId = 'invalid';
      when(() => mockRepository.getUser(userId))
          .thenThrow(UserNotFoundException());

      // When & Then
      expect(
        () => useCase(userId),
        throwsA(isA<UserNotFoundException>()),
      );
    });

    test('should cache user after successful retrieval', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John Doe');
      when(() => mockRepository.getUser(userId))
          .thenReturn(expectedUser);

      // When
      await useCase(userId);
      final cachedUser = await useCase(userId);

      // Then
      expect(cachedUser, equals(expectedUser));
      verify(() => mockRepository.getUser(userId)).called(1);
    });
  });
}
```

### Widget Test Example for Screen

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

class MockUserController extends Mock implements UserController {}

void main() {
  late MockUserController mockController;

  setUp(() {
    mockController = MockUserController();
    Get.testMode = true;
    Get.put<UserController>(mockController);
  });

  tearDown(() {
    Get.reset();
  });

  group('UserScreen Widget Tests', () {
    testWidgets('should display user name when loaded',
        (WidgetTester tester) async {
      // Given
      const user = User(id: '123', name: 'John Doe');
      when(() => mockController.user).thenReturn(user.obs);
      when(() => mockController.isLoading).thenReturn(false.obs);

      // When
      await tester.pumpWidget(
        GetMaterialApp(
          home: UserScreen(),
        ),
      );

      // Then
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('should show loading indicator', (WidgetTester tester) async {
      // Given
      when(() => mockController.user).thenReturn(Rx<User?>(null));
      when(() => mockController.isLoading).thenReturn(true.obs);

      // When
      await tester.pumpWidget(
        GetMaterialApp(
          home: UserScreen(),
        ),
      );

      // Then
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should call loadUser on button tap',
        (WidgetTester tester) async {
      // Given
      when(() => mockController.user).thenReturn(Rx<User?>(null));
      when(() => mockController.isLoading).thenReturn(false.obs);
      when(() => mockController.loadUser(any())).thenAnswer((_) async {});

      // When
      await tester.pumpWidget(
        GetMaterialApp(
          home: UserScreen(),
        ),
      );
      await tester.tap(find.byKey(Key('load_user_button')));
      await tester.pump();

      // Then
      verify(() => mockController.loadUser(any())).called(1);
    });
  });
}
```

### Integration Test Example for User Flow

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('User Login Flow Integration Tests', () {
    testWidgets('should complete login flow successfully',
        (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(MyApp());

      // When - Enter credentials
      await tester.enterText(
        find.byKey(Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(Key('password_field')),
        'password123',
      );

      // When - Tap login button
      await tester.tap(find.byKey(Key('login_button')));
      await tester.pumpAndSettle();

      // Then - Verify navigation to home
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.byKey(Key('home_screen')), findsOneWidget);
    });

    testWidgets('should show error on invalid credentials',
        (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(MyApp());

      // When - Enter invalid credentials
      await tester.enterText(
        find.byKey(Key('email_field')),
        'invalid@example.com',
      );
      await tester.enterText(
        find.byKey(Key('password_field')),
        'wrongpassword',
      );
      await tester.tap(find.byKey(Key('login_button')));
      await tester.pumpAndSettle();

      // Then - Verify error message
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}
```

### Mocktail Mock Example for Repository

```dart
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  group('UserRepository Mock Examples', () {
    test('should mock getUser method', () async {
      // Given
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John Doe');
      when(() => mockRepository.getUser(userId))
          .thenReturn(expectedUser);

      // When
      final result = mockRepository.getUser(userId);

      // Then
      expect(result, equals(expectedUser));
      verify(() => mockRepository.getUser(userId)).called(1);
    });

    test('should mock saveUser method', () async {
      // Given
      const user = User(id: '123', name: 'John Doe');
      when(() => mockRepository.saveUser(user))
          .thenAnswer((_) async => true);

      // When
      final result = await mockRepository.saveUser(user);

      // Then
      expect(result, isTrue);
      verify(() => mockRepository.saveUser(user)).called(1);
    });

    test('should mock deleteUser method', () async {
      // Given
      const userId = '123';
      when(() => mockRepository.deleteUser(userId))
          .thenAnswer((_) async => true);

      // When
      final result = await mockRepository.deleteUser(userId);

      // Then
      expect(result, isTrue);
      verify(() => mockRepository.deleteUser(userId)).called(1);
    });

    test('should mock getAllUsers method', () async {
      // Given
      final users = [
        const User(id: '1', name: 'John'),
        const User(id: '2', name: 'Jane'),
      ];
      when(() => mockRepository.getAllUsers())
          .thenAnswer((_) async => users);

      // When
      final result = await mockRepository.getAllUsers();

      // Then
      expect(result.length, equals(2));
      verify(() => mockRepository.getAllUsers()).called(1);
    });
  });
}
```

## Troubleshooting

### Common Testing Issues

#### Mocktail Setup Problems

**Issue**: Mocks not behaving as expected

**Solution**: Ensure you're using `when(() => mock.method())` syntax with parentheses:

```dart
// Correct
when(() => mockRepository.getUser('123')).thenReturn(user);

// Incorrect
when(mockRepository.getUser('123')).thenReturn(user);
```

#### Isar Testing Issues

**Issue**: Isar database not closing properly

**Solution**: Ensure you close the database in tearDown:

```dart
tearDown(() async {
  await isar.close();
});
```

#### Widget Testing Problems

**Issue**: Widget not updating after state change

**Solution**: Use `pumpAndSettle()` for async operations:

```dart
await tester.tap(button);
await tester.pumpAndSettle(); // Wait for all animations
```

#### Coverage Reporting Issues

**Issue**: Coverage report not generating

**Solution**: Ensure you're using the correct command:

```bash
fvm flutter test --coverage
```

Then install lcov if needed:

```bash
brew install lcov
```

## Checklist for Test Coverage

### Before Submitting Code

- [ ] All public methods have tests
- [ ] All error paths are tested
- [ ] All edge cases are tested
- [ ] All async operations are tested
- [ ] All widget interactions are tested
- [ ] All state changes are tested
- [ ] All database operations are tested
- [ ] All API calls are tested
- [ ] Thai localization is tested where applicable
- [ ] Coverage is at 100%
- [ ] Tests follow Given-When-Then pattern
- [ ] Tests are independent and isolated
- [ ] Test names are descriptive
- [ ] Mocks are properly configured
- [ ] No test interdependence

## Additional Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mocktail Package](https://pub.dev/packages/mocktail)
- [GetX Testing Guide](https://github.com/jonataslaw/getx/blob/master/documentation/en_US/advanced_testing.md)
- [Isar Database Documentation](https://isar.dev)
- [Effective Dart: Testing](https://dart.dev/guides/language/effective-dart/testing)

## Summary

This skill provides comprehensive guidance for creating tests in the UChat Messenger Flutter project. Always use `fvm flutter test` commands, follow the Given-When-Then pattern, and ensure 100% test coverage. Tests mirror the source code structure and cover all layers of the Clean Architecture.
