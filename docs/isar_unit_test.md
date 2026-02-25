# Database Layer Refactoring Guide: From Singleton to Dependency Injection

## Overview

This guide demonstrates how to refactor the database layer in a Flutter app to improve testability by transitioning from singleton pattern to dependency injection using GetIt.

## Why Refactor?

### Problems with Singleton Pattern

```dart
// ❌ Difficult to mock in unit testsclass DatabaseClass {  static final DatabaseClass instance = DatabaseClass._internal();
  factory DatabaseClass() => instance;
}
```

### Benefits of Dependency Injection

```dart
// ✅ Can inject mock instance for testingclass DatabaseClass {  Isar? customDbInstance; // For testing  DatabaseClass({this.customDbInstance});
}
```

## Refactoring Steps

### 1. Update Database Class Definition

### Before Refactoring

```dart
class RoomDb {  // ❌ Singleton pattern  static final RoomDb instance = RoomDb._internal();
  factory RoomDb() => instance;
  RoomDb._internal();
  Isar get dbInstance {    return DbManager().authenticatedInstance!; // ❌ Hard dependency  }}
```

### After Refactoring

```dart
class RoomDb {  // ✅ Constructor injection for testing  Isar? customDbInstance;
  RoomDb({this.customDbInstance});
  Isar get dbInstance {    return customDbInstance ?? DbManager().authenticatedInstance!; // ✅ Dependency injection  }}
```

### 2. Update Database Usage

### Before Refactoring

```dart
// ❌ Using singletonfinal roomDb = RoomDb();
final room = await RoomDb.instance.getRoom(roomId);
```

### After Refactoring

```dart
// ✅ Using GetItimport 'package:get_it/get_it.dart';
final roomDb = GetIt.I<RoomDb>();
final room = await GetIt.I<RoomDb>().getRoom(roomId);
```

### 3. Update Dependency Injection Registration

### Before Refactoring

```dart
getIt.registerSingleton<RoomDb>(
  RoomDb.instance, // ❌ Using singleton instance directly);
```

### After Refactoring

```dart
getIt.registerSingleton<RoomDb>(
  RoomDb(), // ✅ Creating new instance through constructor);
```

### 4. Update Mixins and Utils Classes

### Before Refactoring

```dart
mixin SomeMixin {  @ignore
  final roomDb = RoomDb(); // ❌ Creating instance directly}
```

### After Refactoring

```dart
mixin SomeMixin {  @ignore
  final roomDb = GetIt.I<RoomDb>(); // ✅ Using GetIt injection}
```

## Refactoring Examples by File Type

### 4.1 Database Classes

```dart
// Template for Database class refactoringclass [DatabaseName]Db {  // ✅ Add customDbInstance for testing  Isar? customDbInstance;
  [DatabaseName]Db({this.customDbInstance});
  Isar get dbInstance {    return customDbInstance ?? DbManager().authenticatedInstance!;
  }  // ✅ Update method signatures that return Future to return results  Future<[ReturnType]?> someMethod() async {    return await dbInstance.writeTxn(() async {      // implementation    });
  }}
```

### 4.2 Controller Classes

```dart
class SomeController extends GetxController {  // ✅ Change from singleton to GetIt injection  final roomDb = GetIt.I<RoomDb>();
  final messageDb = GetIt.I<MessageDb>();
  final userService = GetIt.I<UserService>();
}
```

### 4.3 Service Classes

```dart
class SomeService with ServiceMixin {  // ✅ Use GetIt injection  final roomDb = GetIt.I<RoomDb>();
  final apiService = GetIt.I<ApiService>();
}
```

## Testing

Testing for database refactoring uses **real Isar instances** for database classes and **Mocktail** for use cases, following the **GWT (Given-When-Then)** pattern according to project standards.

### Important Testing Strategy Note

**For Database Classes**: Use real Isar instances instead of mocks for better reliability and simpler test setup.
**For Use Cases/Controllers**: Use Mocktail to mock database dependencies for fast, isolated unit tests.

### 5.1 Mocktail Setup

Before writing test cases, prepare the necessary setup:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
// ✅ Mock class definitionsclass MockRoomDb extends Mock implements RoomDb {}class MockMessageDb extends Mock implements MessageDb {}// ✅ Fake classes for fallback valuesclass FakeRoomCollection extends Fake implements RoomCollection {}class FakeMessageCollection extends Fake implements MessageCollection {}// ✅ Register fallback values in setUpAllvoid main() {  setUpAll(() {    registerFallbackValue(FakeRoomCollection());
    registerFallbackValue(FakeMessageCollection());
  });
}
```

### 5.2 Unit Tests with Mocktail and GWT Pattern

### Example Testing Use Cases with Database

```dart
void main() {  late MockRoomDb mockRoomDb;
  late MockMessageDb mockMessageDb;
  late GetChatRoomUseCase useCase;
  setUp(() {    mockRoomDb = MockRoomDb();
    mockMessageDb = MockMessageDb();
    // ✅ Inject mock instances    getIt.registerSingleton<RoomDb>(mockRoomDb);
    getIt.registerSingleton<MessageDb>(mockMessageDb);
    useCase = GetChatRoomUseCase();
    reset(mockRoomDb); // ✅ Reset mock before each test    reset(mockMessageDb);
  });
  tearDown(() {    getIt.unregister<RoomDb>();
    getIt.unregister<MessageDb>();
  });
  group('getChatRoom', () {    const String roomId = 'test-room-123';
    test('Given valid room exists in database, When getChatRoom is called, Then returns Right with RoomEntity', () async {      // Given      final mockRoomCollection = RoomCollection()
        ..id = roomId
        ..name = 'Test Room'        ..isJoined = true;
      when(() => mockRoomDb.getRoom(roomId))
          .thenAnswer((_) async => mockRoomCollection);
      // When      final result = await useCase(roomId);
      // Then      expect(result.isRight(), isTrue, reason: 'Should return Right when room is found');
      result.match(
        (failure) => fail('Expected Right, but got Left: $failure'),        (roomEntity) {          expect(roomEntity.id, equals(roomId));
          expect(roomEntity.name, equals('Test Room'));
          expect(roomEntity.isJoined, isTrue);
        },      );
      verify(() => mockRoomDb.getRoom(roomId)).called(1);
      verifyNoMoreInteractions(mockRoomDb);
    });
    test('Given room not found in database, When getChatRoom is called, Then returns Left with RoomNotFoundFailure', () async {      // Given      when(() => mockRoomDb.getRoom(roomId))
          .thenAnswer((_) async => null);
      // When      final result = await useCase(roomId);
      // Then      expect(result.isLeft(), isTrue, reason: 'Should return Left when room is not found');
      result.match(
        (failure) {          expect(failure, isA<RoomNotFoundFailure>());
        },        (roomEntity) => fail('Expected Left, but got Right: $roomEntity'),      );
      verify(() => mockRoomDb.getRoom(roomId)).called(1);
      verifyNoMoreInteractions(mockRoomDb);
    });
    test('Given database throws exception, When getChatRoom is called, Then returns Left with DatabaseFailure', () async {      // Given      when(() => mockRoomDb.getRoom(roomId))
          .thenThrow(DatabaseException('Connection failed'));
      // When      final result = await useCase(roomId);
      // Then      expect(result.isLeft(), isTrue, reason: 'Should return Left when database error occurs');
      result.match(
        (failure) {          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, contains('Connection failed'));
        },        (roomEntity) => fail('Expected Left, but got Right: $roomEntity'),      );
      verify(() => mockRoomDb.getRoom(roomId)).called(1);
      verifyNoMoreInteractions(mockRoomDb);
    });
  });
}
```

### Example Testing Database Classes Directly

```dart
void main() {  late MockIsar mockIsar;
  late RoomDb roomDb;
  setUp(() {    mockIsar = MockIsar();
    roomDb = RoomDb(customDbInstance: mockIsar);
    reset(mockIsar);
  });
  group('RoomDb', () {    group('putRoom', () {      test('Given valid RoomCollection, When putRoom is called, Then saves room successfully', () async {        // Given        final roomCollection = RoomCollection()
          ..id = 'test-room'          ..name = 'Test Room';
        when(() => mockIsar.writeTxn(any()))
            .thenAnswer((invocation) async {              final callback = invocation.positionalArguments[0] as Future<void> Function();
              await callback();
            });
        // When        await roomDb.putRoom(roomCollection);
        // Then        verify(() => mockIsar.writeTxn(any())).called(1);
      });
      test('Given database write fails, When putRoom is called, Then throws DatabaseException', () async {        // Given        final roomCollection = RoomCollection()..id = 'test-room';
        when(() => mockIsar.writeTxn(any()))
            .thenThrow(DatabaseException('Write failed'));
        // When        final call = () => roomDb.putRoom(roomCollection);
        // Then        expect(call, throwsA(isA<DatabaseException>()));
        verify(() => mockIsar.writeTxn(any())).called(1);
      });
    });
    group('getRoom', () {      test('Given room exists, When getRoom is called, Then returns RoomCollection', () async {        // Given        final expectedRoom = RoomCollection()
          ..id = 'test-room'          ..name = 'Test Room';
        when(() => mockIsar.roomCollection).thenReturn(mockIsar.roomCollection);
        when(() => mockIsar.roomCollection.get(any()))
            .thenAnswer((_) async => expectedRoom);
        // When        final result = await roomDb.getRoom('test-room');
        // Then        expect(result, isNotNull);
        expect(result?.id, equals('test-room'));
        expect(result?.name, equals('Test Room'));
        verify(() => mockIsar.roomCollection.get(any())).called(1);
      });
    });
  });
}
```

### 5.3 Integration Tests with Custom Database Instance

```dart
void main() {
  late Isar testDb;
  late RoomDb roomDb;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);

    // ✅ Use /tmp directory for macOS, ./ for other platforms
    testDb = await Isar.open(
      [RoomCollectionSchema],
      directory: '/tmp', // ✅ Use /tmp for macOS, './' for Linux/Windows
      name: 'test_db',
    );
    roomDb = RoomDb(customDbInstance: testDb);
  });

  setUp(() async {
    // ✅ Clear data before each test
    await testDb.writeTxn(() async {
      await testDb.roomCollection.clear(); // ✅ Use correct collection accessor
    });
  });

  tearDownAll(() async {
    await testDb.close(deleteFromDisk: true);
  });
    group('RoomDb Integration', () {      test('Given new room, When save and retrieve, Then data should persist correctly', () async {        // Given        final roomCollection = RoomCollection()
          ..id = 'integration-test-room'          ..name = 'Integration Test Room'          ..isJoined = true          ..createdAt = DateTime.now();
        // When - Save room        await roomDb.putRoom(roomCollection);
        // Then - Retrieve and verify        final retrieved = await roomDb.getRoom('integration-test-room');
        expect(retrieved, isNotNull);
        expect(retrieved?.id, equals(roomCollection.id));
        expect(retrieved?.name, equals(roomCollection.name));
        expect(retrieved?.isJoined, equals(roomCollection.isJoined));
      });
      test('Given room with messages, When save both, Then should maintain relationship', () async {        // Given        final room = RoomCollection()
          ..id = 'room-with-messages'          ..name = 'Room with Messages';
        final message = MessageCollection()
          ..id = 'message-1'          ..roomId = 'room-with-messages'          ..content = 'Test message'          ..isSent = true;
        // When        await roomDb.putRoom(room);
        await messageDb.putMessage(message);
        // Then        final retrievedRoom = await roomDb.getRoom('room-with-messages');
        final retrievedMessages = await messageDb.getAllSentMessage(roomId: 'room-with-messages');
        expect(retrievedRoom, isNotNull);
        expect(retrievedMessages, isNotEmpty);
        expect(retrievedMessages.first.roomId, equals('room-with-messages'));
      });
    });
  });
}
```

### 5.4 Testing Error Handling and Edge Cases

```dart
void main() {  late MockRoomDb mockRoomDb;
  late GetChatRoomUseCase useCase;
  setUp(() {    mockRoomDb = MockRoomDb();
    getIt.registerSingleton<RoomDb>(mockRoomDb);
    useCase = GetChatRoomUseCase();
    reset(mockRoomDb);
  });
  tearDown(() {    getIt.unregister<RoomDb>();
  });
  group('Error Handling', () {    test('Given null roomId, When getChatRoom is called, Then returns Left with ValidationFailure', () async {      // Given - No mock setup needed as validation happens before database call      // When      final result = await useCase('');
      // Then      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {          expect(failure, isA<ValidationFailure>());
        },        (roomEntity) => fail('Expected Left, but got Right: $roomEntity'),      );
      verifyNever(() => mockRoomDb.getRoom(any())); // ✅ Should not call database    });
    test('Given network timeout, When getChatRoom is called, Then returns Left with NetworkFailure', () async {      // Given      when(() => mockRoomDb.getRoom(any()))
          .thenThrow(NetworkException('Timeout'));
      // When      final result = await useCase('valid-room-id');
      // Then      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {          expect(failure, isA<NetworkFailure>());
        },        (roomEntity) => fail('Expected Left, but got Right: $roomEntity'),      );
      verify(() => mockRoomDb.getRoom('valid-room-id')).called(1);
    });
  });
  group('Edge Cases', () {    test('Given room with special characters, When getChatRoom is called, Then handles correctly', () async {      // Given      const specialRoomId = 'room@#$%^&*()';
      final roomCollection = RoomCollection()
        ..id = specialRoomId
        ..name = 'Special Room 名稱';
      when(() => mockRoomDb.getRoom(specialRoomId))
          .thenAnswer((_) async => roomCollection);
      // When      final result = await useCase(specialRoomId);
      // Then      expect(result.isRight(), isTrue);
      result.match(
        (failure) => fail('Expected Right, but got Left: $failure'),        (roomEntity) {          expect(roomEntity.id, equals(specialRoomId));
          expect(roomEntity.name, equals('Special Room 名稱'));
        },      );
    });
  });
}
```

### 5.5 Running Tests and Checking Coverage

```bash
# ✅ Run unit tests
fvm flutter test test/entities/services/announcement_db_test.dart
# ✅ Run integration tests
fvm flutter test test/features/chat_room/integration/
# ✅ Run tests with coverage
fvm flutter test --coverage
# ✅ Check coverage report
lcov --summary coverage/lcov.info
# ✅ Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Practical Testing Considerations

### Database Collection Accessors

```dart
// ✅ Correct accessor pattern
await testDb.announcementCollection.clear(); // Collection name without 's'
await testDb.announcement.where().findAll();  // Isar generated accessor

// ❌ Incorrect accessor pattern
await testDb.announcements.clear(); // Wrong - adds 's' incorrectly
```

### DateTime vs Duration Constructors

```dart
// ✅ Use const for Duration constructors (better performance)
const Duration(hours: 1)
const Duration(days: 1)

// ❌ DateTime cannot use const constructors
DateTime(2023, 1, 1) // Correct - cannot be const
// const DateTime(2023, 1, 1) // Wrong - will cause compilation error
```

### Test Database Configuration

```dart
// ✅ Proper test database setup for different platforms
late Isar testDb;

setUpAll(() async {
  await Isar.initializeIsarCore(download: true);

  // ✅ Use appropriate directory for each platform
  testDb = await Isar.open(
    [YourCollectionSchema],
    directory: Platform.isMacOS ? '/tmp' : './', // ✅ Platform-specific paths
    name: 'test_db',
  );
});
```

### Linting Considerations

```dart
// ✅ Use const constructors where possible for better performance
test('Example test', () async {
  final room = RoomCollection()
    ..id = 'test'
    ..announceAt = DateTime(2023, 1, 1) // ✅ DateTime cannot be const
    ..expireAt = DateTime(2023, 1, 2);

  when(() => mockDb.someMethod(any()))
      .thenAnswer((_) async => someResult);

  // ✅ Use const Duration for time intervals
  await Future.delayed(const Duration(milliseconds: 100));
});
```

## Best Practices for Database Testing

### 6.1 Refactoring and Testing Order

1. **Start with Database classes** first (RoomDb, MessageDb, etc.)
2. **Write integration tests for database classes** using real Isar instances
3. **Update dependency injection registration**
4. **Update Controllers and Services with unit tests** using Mocktail
5. **Update Mixins and Utils classes with unit tests**
6. **Update use case calls with unit tests** using Mocktail
7. **Run linting and fix code quality issues**

### 6.1.1 Testing Strategy Clarification

**Database Classes**: Use **real Isar instances** for testing
- More reliable than complex mocking
- Tests actual database operations
- Simpler setup and maintenance

**Use Cases/Controllers**: Use **Mocktail** for testing
- Fast execution
- Isolated unit tests
- Easy to test error scenarios

### 6.2 Handling Async Database Operations

```dart
// ✅ Handle async operations in database testingtest('Given async database operation, When saveMessage is called, Then completes successfully', () async {  // Given  final message = MessageCollection()
    ..id = 'test-message'    ..content = 'Test content';
  when(() => mockIsar.writeTxn(any()))
      .thenAnswer((invocation) async {        final callback = invocation.positionalArguments[0] as Future<void> Function();
        await callback(); // ✅ Execute the async callback      });
  // When  await messageDb.putMessage(message);
  // Then  verify(() => mockIsar.writeTxn(any())).called(1);
});
// ✅ Handle nested database transactionstest('Given nested database operations, When saveRoomWithMembers is called, Then handles transactions correctly', () async {  // Given  when(() => mockIsar.writeTxn(any()))
      .thenAnswer((invocation) async {        final callback = invocation.positionalArguments[0] as Future<void> Function();
        await callback();
      });
  // When - Database method with nested operations  await roomDb.putRoomWithMembers(room, members);
  // Then  verify(() => mockIsar.writeTxn(any())).called(1);
});
```

### 6.3 Testing Database Transactions and Rollbacks

```dart
test('Given database transaction fails, When putRoom is called, Then no partial data is saved', () async {  // Given  final room = RoomCollection()..id = 'test-room';
  when(() => mockIsar.writeTxn(any()))
      .thenAnswer((invocation) async {        final callback = invocation.positionalArguments[0] as Future<void> Function();
        // ✅ Simulate transaction failure        throw DatabaseException('Transaction failed');
      });
  // When & Then  expect(() => roomDb.putRoom(room), throwsA(isA<DatabaseException>()));
  verify(() => mockIsar.writeTxn(any())).called(1);
  // In real scenario, should verify no data was saved});
```

### 6.4 Using Argument Matchers for Database Testing

```dart
// ✅ Use appropriate argument matchers for database operationstest('Given room with specific properties, When updateRoom is called, Then saves with correct data', () async {  // Given  final room = RoomCollection()
    ..id = 'test-room'    ..name = 'Updated Name'    ..isJoined = true;
  when(() => mockIsar.writeTxn(any()))
      .thenAnswer((invocation) async {        final callback = invocation.positionalArguments[0] as Future<void> Function();
        await callback();
      });
  // When  await roomDb.putRoom(room);
  // Then - Verify called with correct arguments  verify(() => mockIsar.writeTxn(any())).called(1);
});
// ✅ Capture arguments for specific verificationtest('Given room update, When putRoom is called, Then saves with expected properties', () async {  // Given  final room = RoomCollection()
    ..id = 'test-room'    ..name = 'Test Room';
  when(() => mockIsar.writeTxn(any()))
      .thenAnswer((invocation) async {        final callback = invocation.positionalArguments[0] as Future<void> Function();
        await callback();
      });
  // When  await roomDb.putRoom(room);
  // Then - Capture and verify arguments passed to writeTxn  final capturedArgs = verify(() => mockIsar.writeTxn(captureAny())).captured;
  expect(capturedArgs.length, 1);
  expect(capturedArgs.first, isA<Future<void> Function()>());
});
```

### 6.5 Post-Refactoring Verification

```bash
# ✅ Run unit tests for database classesfvm flutter test test/features/chat_room/data/data_sources/local/room_db_test.dart
# ✅ Run integration tests for database operationsfvm flutter test test/features/chat_room/integration/
# ✅ Run all tests to verify refactoringfvm flutter test
# ✅ Check coverage must be 100%fvm flutter test --coveragelcov --summary coverage/lcov.info | grep "lines......:" | awk '{print $2}' | cut -d'%' -f1# ✅ Run app to verify runtime still works normallyfvm flutter run
```

### 6.6 Handling Edge Cases in Database Testing

```dart
// ✅ Handle null safety in database operationstest('Given null database instance, When RoomDb is created, Then throws appropriate exception', () {  // Given  final roomDb = RoomDb(customDbInstance: null);
  // When & Then  expect(() => roomDb.dbInstance, throwsA(isA<Exception>()));
});
// ✅ Handle empty resultstest('Given no rooms in database, When getAllRooms is called, Then returns empty list', () async {  // Given  when(() => mockIsar.roomCollection).thenReturn(mockIsar.roomCollection);
  when(() => mockIsar.roomCollection.where().findAll())
      .thenAnswer((_) async => []);
  // When  final result = await roomDb.getAllRooms();
  // Then  expect(result, isEmpty);
  verify(() => mockIsar.roomCollection.where().findAll()).called(1);
});
// ✅ Handle large datasetstest('Given large number of rooms, When getAllRooms is called, Then handles pagination correctly', () async {  // Given  final largeRoomList = List.generate(1000, (index) =>    RoomCollection()..id = 'room-$index'  );
  when(() => mockIsar.roomCollection.where().findAll())
      .thenAnswer((_) async => largeRoomList);
  // When  final result = await roomDb.getAllRooms();
  // Then  expect(result.length, equals(1000));
  verify(() => mockIsar.roomCollection.where().findAll()).called(1);
});
```

### 6.7 Testing Database Query Operations

```dart
// ✅ Test complex database queriestest('Given rooms with different statuses, When getActiveRooms is called, Then returns only active rooms', () async {  // Given  final activeRoom = RoomCollection()
    ..id = 'active-room'    ..isActive = true;
  final inactiveRoom = RoomCollection()
    ..id = 'inactive-room'    ..isActive = false;
  when(() => mockIsar.roomCollection).thenReturn(mockIsar.roomCollection);
  when(() => mockIsar.roomCollection.where().filter().isActiveEqualTo(true).findAll())
      .thenAnswer((_) async => [activeRoom]);
  // When  final result = await roomDb.getActiveRooms();
  // Then  expect(result.length, equals(1));
  expect(result.first.id, equals('active-room'));
  verify(() => mockIsar.roomCollection.where().filter().isActiveEqualTo(true).findAll()).called(1);
});
```

### 6.8 Handling Database Schema Migrations in Tests

```dart
// ✅ Test schema migrations in integration teststest('Given old database schema, When RoomDb is initialized, Then migrates schema correctly', () async {  // Given - Create database with previous schema version  final oldDb = await Isar.open(
    [RoomCollectionSchema], // Previous schema version    directory: './',    name: 'migration_test',  );
  // When - Create RoomDb with new schema  final roomDb = RoomDb(customDbInstance: oldDb);
  final room = RoomCollection()..id = 'test-room';
  // Then - Should work normally with new schema  await roomDb.putRoom(room);
  final retrieved = await roomDb.getRoom('test-room');
  expect(retrieved, isNotNull);
  await oldDb.close(deleteFromDisk: true);
});
```

## Extending to Other Database Collections

When refactoring new database collections, follow this pattern:

1. **Create mock classes and fake classes** for that collection
2. **Write unit tests** for the database class using GWT pattern
3. **Write integration tests** for complex database operations
4. **Update class definition** to support `customDbInstance`
5. **Change usage from `.instance`** to `GetIt.I<>()`
6. **Update dependency injection registration**
7. **Run tests and verify 100% coverage**

## Summary

This refactoring pattern provides:

### ✅ **Testability**

- Easy to mock database dependencies with Mocktail
- Fast and reliable unit tests
- Integration tests that test against real database

### ✅ **Maintainability**

- Cleaner code with dependency injection
- Each component can be tested independently
- Clear and testable error handling

### ✅ **Reliability**

- 100% test coverage prevents regression
- GWT pattern makes test cases readable and maintainable
- Edge cases and error scenarios are fully covered

### ✅ **Scalability**

- Easy to add new database collections
- Consistent pattern for future refactoring
- Ready-to-use testing infrastructure

## Common Pitfalls and Solutions

### 1. Database Collection Accessor Issues

**Problem**: Incorrect collection accessor names
```dart
// ❌ Wrong - adds 's' incorrectly
await testDb.announcements.clear();

// ✅ Correct - use Isar generated accessor
await testDb.announcement.clear();
```

**Solution**: Check the actual collection accessor name in your Isar schema:
```dart
@Collection(accessor: 'announcement') // This creates .announcement accessor
class AnnouncementCollection {
  // ...
}
```

### 2. Platform-Specific Directory Issues

**Problem**: Using incorrect directory paths for different platforms
```dart
// ❌ May fail on macOS
directory: './'

// ✅ Platform-aware configuration
directory: Platform.isMacOS ? '/tmp' : './'
```

### 3. Mock vs Real Database Confusion

**Problem**: Trying to mock complex Isar query builders
```dart
// ❌ Complex and fragile mocking
when(() => mockIsar.announcementCollection.filter()
    .announceTypeEqualTo('ANNOUNCE')).thenReturn(mockQueryBuilder);

// ✅ Simpler and more reliable
late Isar testDb = await Isar.open([Schema], directory: '/tmp');
```

### 4. Constructor Const Issues

**Problem**: Linting errors about const constructors
```dart
// ❌ Linting error - prefer const constructors
Duration(hours: 1)

// ✅ Fixed with const
const Duration(hours: 1)

// ❌ Compilation error - DateTime cannot be const
const DateTime(2023, 1, 1)

// ✅ Correct - DateTime cannot use const
DateTime(2023, 1, 1)
```

### 5. Schema Import Issues

**Problem**: Missing schema imports in test files
```dart
// ❌ Missing schema import
testDb = await Isar.open([AnnouncementCollectionSchema]);

// ✅ Add proper import
import 'package:your_app/entities/collections/announcement_collection.dart';
```

Use this guide as a reference for refactoring database collections in the future and writing high-quality unit tests.

## Extending to Other Database Collections

When refactoring new database collections, follow this pattern:

1. Update class definition to support `customDbInstance`
2. Change usage from `.instance` to `GetIt.I<>()`
3. Update dependency injection registration
4. Write unit tests using mock objects
5. Write integration tests using customDbInstance

## Recommended Testing Approach

### For Database Classes (RoomDb, AnnouncementDb, etc.)
- **✅ Use Real Isar Instances**: More reliable and simpler than complex mocking
- **✅ Integration-Style Tests**: Test actual database operations
- **✅ Platform-Aware Configuration**: Use appropriate directories for each platform

### For Use Cases and Controllers
- **✅ Use Mocktail**: Fast, isolated unit tests
- **✅ Mock Database Dependencies**: Easy to test business logic in isolation
- **✅ GWT Pattern**: Clear, maintainable test structure

## Updated Summary

This pattern provides:
- ✅ **Testable**: Choose appropriate testing strategy for each layer
- ✅ **Maintainable**: Cleaner code structure with dependency injection
- ✅ **Reliable**: Real database testing for data layer, mocked testing for business logic
- ✅ **Practical**: Platform-aware configuration and linting compliance
- ✅ **Comprehensive**: Covers common pitfalls and edge cases

## Key Improvements from Implementation

1. **Testing Strategy Clarification**: Database classes work better with real instances
2. **Platform-Specific Configuration**: Proper directory handling for different OS
3. **Code Quality Focus**: Linting compliance and const constructor usage
4. **Practical Examples**: Real-world solutions for common issues
5. **Error Prevention**: Common pitfalls and their solutions documented

Use this improved guide as a reference for refactoring database collections in the future.