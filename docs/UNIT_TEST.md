# UChat Flutter Project - Unit Test Generation Guide

**Objective:** This document provides comprehensive and strict guidelines for writing unit tests in the UChat Flutter project. It is optimized for Large Language Model (LLM) understanding and consumption to facilitate automated or semi-automated generation of compliant unit tests. Adherence to these standards is mandatory.

## Core Principles for LLM-based Test Generation

1.  **Strict Adherence:** All rules and patterns described herein MUST be followed.
2.  **Given-When-Then (GWT):** Every test MUST use the GWT structure, both in naming and internal comments.
3.  **100% Coverage:** All new and modified code (classes, methods, lines, branches) MUST achieve 100% unit test coverage.
4.  **Mocktail Exclusively:** Mocktail is the ONLY mocking library to be used. No code generation for mocks is permitted.
5.  **`fpdart` `Either` Type:** Testing methods returning `Either` MUST follow the specific patterns outlined.
6.  **Clarity and Explicitness:** Tests must be easy to understand. Assertion messages should be clear.
7.  **File Organization:** Test files MUST mirror the `lib/` directory structure under `test/`.

---

## Table of Contents

1.  [**I. Unit Test Fundamentals**](#i-unit-test-fundamentals)
    *   [A. Test Structure: Given-When-Then (GWT)](#a-test-structure-given-when-then-gwt)
        *   [1. Test Naming Convention](#1-test-naming-convention)
        *   [2. Mandatory Internal Comments](#2-mandatory-internal-comments)
    *   [B. Code Coverage: 100% Mandatory](#b-code-coverage-100-mandatory)
        *   [1. Scope of Coverage](#1-scope-of-coverage)
        *   [2. Specific Enum Testing](#2-specific-enum-testing)
    *   [C. Test File Organization](#c-test-file-organization)
2.  [**II. Mocking with Mocktail**](#ii-mocking-with-mocktail)
    *   [A. Defining Mock Classes](#a-defining-mock-classes)
    *   [B. Stubbing Methods and Getters](#b-stubbing-methods-and-getters)
        *   [1. Synchronous Methods](#1-synchronous-methods)
        *   [2. Asynchronous Methods (`Future`)](#2-asynchronous-methods-future)
        *   [3. Asynchronous Methods (`Future<Either<L, R>>`)](#3-asynchronous-methods-futureeitherl-r)
        *   [4. Getters](#4-getters)
    *   [C. Verifying Interactions](#c-verifying-interactions)
    *   [D. Argument Matchers](#d-argument-matchers)
    *   [E. Fallback Values for Custom Types](#e-fallback-values-for-custom-types)
        *   [1. Using `registerFallbackValue`](#1-using-registerfallbackvalue)
        *   [2. Using `Fake` Classes](#2-using-fake-classes)
    *   [F. Mocktail Best Practices & Troubleshooting](#f-mocktail-best-practices--troubleshooting)
        *   [1. Key Best Practices](#1-key-best-practices)
        *   [2. Common Issues & Solutions](#2-common-issues--solutions)
3.  [**III. Advanced Testing Patterns**](#iii-advanced-testing-patterns)
    *   [A. Testing `Either` Types (`fpdart`)](#a-testing-either-types-fpdart)
        *   [1. Testing `Right` (Success) Case](#1-testing-right-success-case)
        *   [2. Testing `Left` (Failure) Case](#2-testing-left-failure-case)
        *   [3. Nested Assertions for Complex Failures](#3-nested-assertions-for-complex-failures)
    *   [B. Comprehensive Exception Handling Tests](#b-comprehensive-exception-handling-tests)
    *   [C. Verifying Property Assignments](#c-verifying-property-assignments)
    *   [D. Testing Execution Flow](#d-testing-execution-flow)
4.  [**IV. Test Execution & Reporting**](#iv-test-execution--reporting)
    *   [A. Flutter Version Management (FVM)](#a-flutter-version-management-fvm)
    *   [B. Running Tests](#b-running-tests)
    *   [C. Generating and Verifying Coverage](#c-generating-and-verifying-coverage)
5.  [**V. Complete End-to-End Examples**](#v-complete-end-to-end-examples)
    *   [A. Repository Pattern Test Example](#a-repository-pattern-test-example)
    *   [B. Use Case Test Example](#b-use-case-test-example)
6.  [**VI. Exemplary Implementation Reference**](#vi-exemplary-implementation-reference)

---

## I. Unit Test Fundamentals

### A. Test Structure: Given-When-Then (GWT)
All unit tests MUST strictly follow the **Given-When-Then** pattern. This pattern structures tests into three distinct phases:
*   **Given:** Setup of pre-conditions, mock initializations, and input data.
*   **When:** Execution of the code under test.
*   **Then:** Assertion of expected outcomes and verification of interactions.

#### 1. Test Naming Convention
The `test()` description string MUST clearly articulate the GWT scenario:
`test('Given [Context/Precondition], When [Action Performed], Then [Expected Outcome]', () { ... });`

**Example:**
```dart
// CORRECT: Clear GWT in test name
test('Given a valid JSON map, When MyClass.fromJson is called, Then returns a correct MyClass instance', () {
  // Test implementation
});
```

#### 2. Mandatory Internal Comments
Within each test case, explicit comments `// Given`, `// When`, `// Then` MUST be used to delineate the GWT phases.

**Example:**
```dart
test('Given a valid user ID, When getUser is called, Then returns the corresponding UserEntity', () {
  // Given
  final mockUserRepository = MockUserRepository();
  final userId = '123';
  final expectedUser = UserEntity(id: userId, name: 'Test User');
  when(() => mockUserRepository.getUser(userId)).thenReturn(expectedUser);
  final systemUnderTest = GetUserUseCase(repository: mockUserRepository);

  // When
  final actualUser = systemUnderTest.call(userId);

  // Then
  expect(actualUser, equals(expectedUser));
  verify(() => mockUserRepository.getUser(userId)).called(1);
});
```

### B. Code Coverage: 100% Mandatory
All new or modified classes, methods, lines, and branches MUST achieve **100% unit test coverage**. This is non-negotiable.

#### 1. Scope of Coverage
Ensure tests cover:
*   All constructors (default, factory, named).
*   All public methods and getters/setters.
*   Serialization/deserialization methods (e.g., `toMap`, `fromJson`).
*   Equality operators (`==`) and `hashCode` implementations.
*   All possible execution paths within methods (e.g., if/else branches, switch cases).
*   Edge cases (e.g., null inputs, empty lists, zero values) where applicable.
*   Error handling paths and expected exception throwing/catching.

#### 2. Specific Enum Testing
Enums used in business logic or serialization MUST be tested explicitly, especially their string representations or factory constructors.

**Example: Testing an enum's `fromString` factory or similar lookup:**
```dart
enum Status { active, inactive }

Status statusFromString(String value) {
  if (value == 'active') return Status.active;
  if (value == 'inactive') return Status.inactive;
  throw ArgumentError('Unknown status: $value');
}

test('Given "active" string, When statusFromString is called, Then returns Status.active', () {
  // Given
  const stringValue = 'active';
  
  // When
  final result = statusFromString(stringValue);
  
  // Then
  expect(result, equals(Status.active));
});

test('Given "inactive" string, When statusFromString is called, Then returns Status.inactive', () {
  // Given
  const stringValue = 'inactive';

  // When
  final result = statusFromString(stringValue);

  // Then
  expect(result, equals(Status.inactive));
});

test('Given an invalid string, When statusFromString is called, Then throws ArgumentError', () {
  // Given
  const invalidString = 'unknown';

  // When
  final call = () => statusFromString(invalidString);

  // Then
  expect(call, throwsA(isA<ArgumentError>()));
});
```

### C. Test File Organization
*   Test files MUST be located in the `test/` directory.
*   The path to a test file MUST mirror the path of the source file in `lib/`.
*   Test filenames MUST end with `_test.dart`.

**Example:**
*   Source file: `lib/features/auth/domain/use_cases/get_user_use_case.dart`
*   Test file: `test/features/auth/domain/use_cases/get_user_use_case_dart`

---

## II. Mocking with Mocktail

[Mocktail](https://pub.dev/packages/mocktail) is the ONLY approved mocking library. It requires no code generation.

### A. Defining Mock Classes
Create mocks by extending `Mock` and implementing the class/interface to be mocked. Place mock class definitions at the top of the test file or in a shared test utility file if widely used.

```dart
import 'package:mocktail/mocktail.dart';
// Import the actual class/interface to be mocked
import 'package:uchat/features/auth/domain/repositories/user_repository.dart'; 

// Mock definition
class MockUserRepository extends Mock implements UserRepository {}
```

### B. Stubbing Methods and Getters
Use `when(...).thenAnswer(...)` for `async` methods and `when(...).thenReturn(...)` for synchronous methods or getters. Use `when(...).thenThrow(...)` to stub throwing an exception.

#### 1. Synchronous Methods
```dart
// Given
final mockService = MockMyService();
when(() => mockService.getSomeValue()).thenReturn(42); // Stubbing a method
when(() => mockService.anotherMethod('input')).thenThrow(Exception('Test error')); // Stubbing to throw

// When
final value = mockService.getSomeValue();
final call = () => mockService.anotherMethod('input');

// Then
expect(value, 42);
expect(call, throwsException);
```

#### 2. Asynchronous Methods (`Future`)
ALWAYS use `thenAnswer((_) async => ...)` for methods returning a `Future`.

```dart
// Stubbing a Future<String>
when(() => mockService.fetchData()).thenAnswer((_) async => 'mocked data');

// Stubbing a Future<void>
when(() => mockService.performAction()).thenAnswer((_) async {}); // Empty async block

// Stubbing a Future that throws
when(() => mockService.fetchDataWithError()).thenAnswer((_) async => throw Exception('Network error'));
```
**Incorrect stubbing for `Future` (AVOID THIS):**
```dart
// INCORRECT: This will lead to mockService.fetchData() returning a Future<null> if 'user' is not a Future.
// when(() => mockService.fetchData()).thenReturn(user); // AVOID for async if 'user' isn't already a Future
```

#### 3. Asynchronous Methods (`Future<Either<L, R>>`)
This is a common pattern in the project using `fpdart`.

```dart
import 'package:fpdart/fpdart.dart';

// Assuming:
// abstract class Failure {}
// class ServerFailure extends Failure {}
// class User {}

// Stubbing a Future<Either<Failure, User>> for a success case (Right)
final mockUser = User(); // Assume User is defined
when(() => mockRepository.getUserEither('id'))
    .thenAnswer((_) async => Right<Failure, User>(mockUser));

// Stubbing a Future<Either<Failure, User>> for a failure case (Left)
final serverFailure = ServerFailure(); // Assume ServerFailure is defined
when(() => mockRepository.getUserEither('id_error'))
    .thenAnswer((_) async => Left<Failure, User>(serverFailure));
```

#### 4. Getters
```dart
// Stubbing a getter
when(() => mockService.isActive).thenReturn(true);
```

### C. Verifying Interactions
Verify method calls using `verify(...)` and `verifyNever(...)`.

```dart
// Verify a method was called exactly once with specific arguments
verify(() => mockRepository.saveUser(expectedUser)).called(1);

// Verify a method was never called
verifyNever(() => mockRepository.deleteUser(any()));

// Verify order of calls (if necessary, use sparingly)
// verifyInOrder([
//   () => mockService.firstCall(),
//   () => mockService.secondCall(),
// ]);

// Capture arguments for more complex assertions
final capturedArgs = verify(() => mockRepository.updateUser(captureAny())).captured;
expect(capturedArgs.length, 1);
expect(capturedArgs.first.id, 'user123');
```

### D. Argument Matchers
Use argument matchers for flexible stubbing and verification when exact values are not needed or vary.

*   `any()`: Matches any argument for that position.
    *   If the parameter is named, use `any(named: 'paramName')`.
    *   For custom types with `any()`, `registerFallbackValue` is often required (see below).
*   `argThat(matcher)`: Matches an argument that satisfies the provided `Matcher` (e.g., `equals()`, `isA<T>()`, `contains()`).
*   `captureAny()`: Captures any argument for later inspection.
    *   If the parameter is named, use `captureAny(named: 'paramName')`.

```dart
// Stubbing with any()
when(() => mockService.processItem(any())).thenReturn(true);

// Verification with argThat() and isA<T>()
when(() => mockService.processData(any(that: isA<String>()))).thenReturn('processed');
verify(() => mockService.processData(argThat(startsWith('test')))).called(1);
```

### E. Fallback Values for Custom Types
When using `any()` or `captureAny()` with parameters of custom (non-primitive) types, Mocktail needs a way to create a default instance if one isn't explicitly provided in `when()`. This is done via `registerFallbackValue` or by creating `Fake` classes.

#### 1. Using `registerFallbackValue`
Register a fallback instance in `setUpAll` or `setUp`.

```dart
class MyCustomType {
  final String id;
  MyCustomType(this.id);
  // Add equals and hashCode if comparing instances
}

// In your test file:
setUpAll(() {
  registerFallbackValue(MyCustomType('fallback_id')); 
});

// Later in a test or setup:
when(() => mockService.processCustomType(any())).thenReturn(true); 
// Mocktail can now use the registered MyCustomType('fallback_id') if needed for `any()`
```

#### 2. Using `Fake` Classes
For complex types or when providing a real instance is difficult, use a `Fake` class.

```dart
class ComplexServiceResponse {
  // ... many properties and methods
}

class FakeComplexServiceResponse extends Fake implements ComplexServiceResponse {}

// In your test file:
setUpAll(() {
  registerFallbackValue(FakeComplexServiceResponse());
});

when(() => mockService.getComplexResponse(any())).thenAnswer((_) async => FakeComplexServiceResponse());
```

### F. Mocktail Best Practices & Troubleshooting

#### 1. Key Best Practices
*   **`setUpAll` for Fallbacks:** Register all necessary fallback values in `setUpAll`.
*   **`reset(mock)`:** In `setUp` or `tearDown`, call `reset(yourMockInstance)` for each mock to clear its recorded calls and stubs between tests, ensuring test isolation.
*   **Organize Mocks:** Define mock classes at the top of the test file.
*   **Stub Asynchronous Returns:** ALWAYS use `thenAnswer((_) async => ...)` for methods returning `Future` or `Stream` to prevent `Future<null>` issues.
*   **Specificity:** Be as specific as possible with argument matchers in `when()`. Use `any()` judiciously.

#### 2. Common Issues & Solutions
*   **`MissingStubError`**: You called a method on a mock that wasn't stubbed. Ensure `when()` is set up for that call.
*   **`No fallback value was found for type 'X'`**: Call `registerFallbackValue(X())` or `registerFallbackValue(FakeX())` in `setUpAll` if you use `any()` or `captureAny()` with type `X`.
*   **Unstubbed async method returns `Future<null>`**: You used `thenReturn(someValue)` for an async method where `someValue` was not a `Future`. Use `thenAnswer((_) async => someValue)` instead.
*   **Extension Methods Cannot Be Mocked/Verified**: Mocktail works on instance members of the mocked class. Extension methods are static and resolved at compile time, so they cannot be directly mocked or verified on a mock object. Test them by testing the class they extend or by testing them as static utility functions if possible.

---

## III. Advanced Testing Patterns

### A. Testing `Either` Types (`fpdart`)
Methods returning `Either<L, R>` (typically `Either<Failure, SuccessType>`) are common. Tests MUST cover both `Left` (failure) and `Right` (success) paths.

#### 1. Testing `Right` (Success) Case
```dart
// Assuming:
// class MySuccessData { final String data; MySuccessData(this.data); /* implement == and hashCode */ }
// class MyFailure { final String message; MyFailure(this.message); /* implement == and hashCode */ }
// Future<Either<MyFailure, MySuccessData>> functionUnderTest();

test('Given successful operation, When functionUnderTest is called, Then returns Right with MySuccessData', () async {
  // Given
  final expectedData = MySuccessData('success');
  when(() => mockDependency.someAsyncCall()).thenAnswer((_) async => expectedData); 
  // Assuming functionUnderTest internally calls mockDependency.someAsyncCall() and wraps it in Right

  // When
  final result = await systemUnderTest.functionReturningEither(); // systemUnderTest uses mockDependency

  // Then
  expect(result.isRight(), isTrue, reason: 'Expected Right, but was Left: ${result.fold((l) => l, (r) => null)}');
  result.match(
    (left) => fail('Test failed: Expected Right, but got Left: ${left.message}'),
    (right) => expect(right, equals(expectedData)), // Ensure MySuccessData has == override
  );
});
```

#### 2. Testing `Left` (Failure) Case
```dart
test('Given a dependency error, When functionUnderTest is called, Then returns Left with MyFailure', () async {
  // Given
  final expectedFailure = MyFailure('network error');
  when(() => mockDependency.someAsyncCall()).thenThrow(Exception('Simulated error'));
  // Assuming functionUnderTest catches this Exception and maps it to MyFailure, returning Left

  // When
  final result = await systemUnderTest.functionReturningEither();

  // Then
  expect(result.isLeft(), isTrue, reason: 'Expected Left, but was Right: ${result.fold((l) => null, (r) => r)}');
  result.match(
    (left) => expect(left, equals(expectedFailure)), // Ensure MyFailure has == override
    (right) => fail('Test failed: Expected Left, but got Right: ${right.data}'),
  );
});
```

#### 3. Nested Assertions for Complex Failures
If `Failure` objects are complex, assert their properties within the `match` block.
```dart
result.match(
  (failure) {
    expect(failure, isA<SpecificFailureType>());
    final specificFailure = failure as SpecificFailureType;
    expect(specificFailure.errorCode, equals(101));
    expect(specificFailure.details, contains('database'));
  },
  (right) => fail('Expected Left, got Right'),
);
```

### B. Comprehensive Exception Handling Tests
*   **Test Transformation:** If a method catches one type of exception and throws another (or returns a `Left`), verify this transformation.
*   **Test Specific Exception Types:** If a method handles different exceptions differently, test each path.

```dart
test('Given dependency throws SpecificException, When method is called, Then returns Left with TransformedFailure', () async {
  // Given
  when(() => mockDependency.action()).thenThrow(SpecificException('details'));
  
  // When
  final result = await systemUnderTest.methodWithExceptionHandling();
  
  // Then
  expect(result.isLeft(), isTrue);
  result.match(
    (l) => expect(l, isA<TransformedFailure>()),
    (_) => fail('Expected Left'),
  );
});

test('Given dependency throws UnhandledException, When method is called, Then re-throws UnhandledException', () async {
  // Given
  when(() => mockDependency.action()).thenThrow(UnhandledException());

  // When
  final call = systemUnderTest.methodWithExceptionHandling(); // Assuming it re-throws

  // Then
  expect(call, throwsA(isA<UnhandledException>()));
});
```

### C. Verifying Property Assignments
If a method's side effect includes setting a property on a mock (or a real object if not using mocks for it), verify this. This is less common with pure functional approaches but can occur.
```dart
// class MockObjectWithProperty extends Mock {
//   String? someProperty;
// }
// ...
// verify(() => mockObject.someProperty = 'expectedValue').called(1);
// verifyNever(() => mockObject.someProperty = any());
```
**Note:** Direct property assignment verification on mocks is limited with Mocktail. Prefer testing outcomes and interactions. If a property on a *mocked dependency* is set, you'd typically mock the setter if it's a public method.

### D. Testing Execution Flow
Verify that methods are called (or not called) in the correct sequence or based on conditions.

```dart
test('Given firstCall throws, When process is called, Then secondCall is never invoked', () async {
  // Given
  when(() => mockDependency.firstCall()).thenThrow(Exception('Error in first call'));
  
  // When
  try {
    await systemUnderTest.process();
  } catch (_) {
    // Expected exception
  }
  
  // Then
  verify(() => mockDependency.firstCall()).called(1);
  verifyNever(() => mockDependency.secondCall());
});

test('Given condition is true, When processConditional is called, Then truePath is called and falsePath is not', () async {
  // Given
  when(() => mockDependency.checkCondition()).thenReturn(true);
  when(() => mockDependency.truePath()).thenAnswer((_) async {});
  when(() => mockDependency.falsePath()).thenAnswer((_) async {});

  // When
  await systemUnderTest.processConditional();

  // Then
  verify(() => mockDependency.truePath()).called(1);
  verifyNever(() => mockDependency.falsePath());
});
```

---

## IV. Test Execution & Reporting

### A. Flutter Version Management (FVM)
The UChat project uses FVM. All Flutter commands MUST be prefixed with `fvm`.
*   Setup: `fvm install` then `fvm use`. (Refer to official FVM docs for installation).

### B. Running Tests
*   Run all tests: `fvm flutter test`
*   Run a specific file: `fvm flutter test path/to/your_test_file_test.dart`
*   Run tests by name: `fvm flutter test --name="Given scenario X"`

### C. Generating and Verifying Coverage
1.  **Run tests with coverage flag:**
    ```bash
    fvm flutter test --coverage
    ```
    This generates `coverage/lcov.info`.

2.  **Check coverage summary (requires `lcov` tool):**
    ```bash
    # Ensure lcov is installed (e.g., brew install lcov on macOS)
    lcov --summary coverage/lcov.info
    ```
    Review line, function, and branch coverage.

3.  **Verify 100% Line Coverage (for CI/CD or local check):**
    ```bash
    # This command exits with 0 if line coverage is 100%, 1 otherwise.
    lcov --summary coverage/lcov.info | grep "lines......:" | awk '{print $2}' | cut -d'%' -f1 | awk '{if($1 < 100.0) exit 1; else exit 0;}'
    ```
    Adapt for branch/function coverage if needed.

4.  **Generate HTML Report (Optional, for detailed view):**
    ```bash
    genhtml coverage/lcov.info -o coverage/html
    open coverage/html/index.html
    ```

---

## V. Complete End-to-End Examples

*(These examples integrate many of the principles above. Study them carefully.)*

### A. Repository Pattern Test Example
```dart
// test/features/auth/data/repositories/user_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uchat/core/error/failures.dart'; // Assuming Failure, CacheFailure exist
import 'package:uchat/features/auth/data/datasources/user_local_datasource.dart'; // Actual dependency
import 'package:uchat/features/auth/data/repositories/user_repository_impl.dart'; // System Under Test
import 'package:uchat/features/auth/domain/entities/user_entity.dart'; // Actual entity

// Mock Definitions
class MockUserLocalDatasource extends Mock implements UserLocalDatasource {}
class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserLocalDatasource mockLocalDatasource;
  late UserEntity tUserEntity;

  setUpAll(() {
    registerFallbackValue(FakeUserEntity()); // For any(named: 'user') if used
  });

  setUp(() {
    mockLocalDatasource = MockUserLocalDatasource();
    repository = UserRepositoryImpl(localDatasource: mockLocalDatasource);
    tUserEntity = UserEntity(id: '1', name: 'Test User', email: 'test@example.com');
    reset(mockLocalDatasource); // Reset mock before each test
  });

  group('getUser', () {
    const tUserId = '1';
    test('Given local datasource returns a UserEntity, When getUser is called, Then returns Right(UserEntity)', () async {
      // Given
      when(() => mockLocalDatasource.getUser(tUserId)).thenAnswer((_) async => tUserEntity);

      // When
      final result = await repository.getUser(tUserId);

      // Then
      expect(result.isRight(), isTrue);
      result.match(
        (failure) => fail('Expected Right, got Left: $failure'),
        (user) => expect(user, equals(tUserEntity)),
      );
      verify(() => mockLocalDatasource.getUser(tUserId)).called(1);
      verifyNoMoreInteractions(mockLocalDatasource);
    });

    test('Given local datasource throws CacheException, When getUser is called, Then returns Left(CacheFailure)', () async {
      // Given
      when(() => mockLocalDatasource.getUser(tUserId)).thenThrow(CacheException('DB error'));
      final expectedFailure = CacheFailure(message: 'DB error');


      // When
      final result = await repository.getUser(tUserId);

      // Then
      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<CacheFailure>());
          // If CacheFailure has specific properties to check, do it here.
          // For this example, direct equality might not work if CacheFailure instances are different.
          // So, checking type and message if applicable.
          expect((failure as CacheFailure).message, expectedFailure.message);
        },
        (user) => fail('Expected Left, got Right: $user'),
      );
      verify(() => mockLocalDatasource.getUser(tUserId)).called(1);
      verifyNoMoreInteractions(mockLocalDatasource);
    });
  });

  group('saveUser', () {
    test('Given local datasource saveUser completes, When saveUser is called, Then returns Right(null)', () async {
      // Given
      // For Future<void> from datasource, thenAnswer with empty async block
      when(() => mockLocalDatasource.saveUser(tUserEntity)).thenAnswer((_) async {});

      // When
      final result = await repository.saveUser(tUserEntity);

      // Then
      expect(result.isRight(), isTrue);
      result.match(
        (failure) => fail('Expected Right, got Left: $failure'),
        (success) => expect(success, isNull), // For Right<Failure, void>, success is null
      );
      verify(() => mockLocalDatasource.saveUser(tUserEntity)).called(1);
      verifyNoMoreInteractions(mockLocalDatasource);
    });
  });
}
```

### B. Use Case Test Example
```dart
// test/features/auth/domain/use_cases/get_user_use_case_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uchat/core/error/failures.dart'; // Assuming Failure, ServerFailure exist
import 'package:uchat/features/auth/domain/entities/user_entity.dart'; // Actual entity
import 'package:uchat/features/auth/domain/repositories/user_repository.dart'; // Actual dependency interface
import 'package:uchat/features/auth/domain/use_cases/get_user_use_case.dart'; // System Under Test

// Mock Definitions
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetUserUseCase useCase;
  late MockUserRepository mockUserRepository;
  late UserEntity tUserEntity;
  const tUserId = 'user123';

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetUserUseCase(repository: mockUserRepository);
    tUserEntity = UserEntity(id: tUserId, name: 'Test User', email: 'test@example.com');
    reset(mockUserRepository); // Reset mock before each test
  });

  test('Given repository returns UserEntity successfully, When GetUserUseCase is called, Then returns Right(UserEntity)', () async {
    // Given
    when(() => mockUserRepository.getUser(tUserId))
        .thenAnswer((_) async => Right(tUserEntity));

    // When
    final result = await useCase(const GetUserParams(userId: tUserId)); // Assuming GetUserParams exists

    // Then
    expect(result, equals(Right<Failure, UserEntity>(tUserEntity)));
    verify(() => mockUserRepository.getUser(tUserId)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('Given repository returns a Failure, When GetUserUseCase is called, Then returns Left(Failure)', () async {
    // Given
    final tFailure = ServerFailure(message: 'Server error');
    when(() => mockUserRepository.getUser(tUserId))
        .thenAnswer((_) async => Left(tFailure));

    // When
    final result = await useCase(const GetUserParams(userId: tUserId));

    // Then
    expect(result, equals(Left<Failure, UserEntity>(tFailure)));
    verify(() => mockUserRepository.getUser(tUserId)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
```

---

## VI. Exemplary Implementation Reference
For a comprehensive, real-world example adhering to these guidelines, refer to:
`test/features/auth/data/repositories/user_local_repository_impl_test.dart` (Note: This is an example path, replace with an actual exemplary file from your project if available, or aim to make one.)

This file should demonstrate:
*   100% test coverage for its corresponding source file.
*   Strict GWT structure in all tests.
*   Effective mocking of all dependencies.
*   Clear testing of `Either` success and failure paths.
*   Thorough exception handling tests.
*   Detailed verification of interactions.
*   Coverage of edge cases.

By following this guide, generated unit tests will be consistent, robust, and maintainable.