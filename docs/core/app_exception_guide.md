# AppException Guide

## Overview

`AppException` is the root exception class for all **in-app** (non-API, non-socket) errors in UChat Messenger. It provides a consistent, typed exception hierarchy that makes error handling predictable and debuggable.

> **Scope**: This guide covers only app-level exceptions. For API errors see `ApiException`, for socket errors see `SocketIOException` and friends.

---

## Exception Hierarchy

```
Exception (dart:core)
└── AppException                         — general in-app errors
    ├── NoInternetException              — device is offline
    ├── DatabaseException                — base for all local DB (Isar) errors
    │   ├── DatabaseNotInitializedException  — DB instance is null / not opened
    │   ├── DatabaseOpenException             — Isar.open() failed
    │   ├── DatabaseReadException             — query / read failed
    │   ├── DatabaseWriteException            — put / update / delete failed
    │   └── DatabaseCloseException            — close operation failed
    ├── CacheException                   — SharedPreferences / in-memory cache errors
    ├── InvalidStateException            — object in unexpected state
    └── MultipleAccountLimitExceedException — account limit reached
```

---

## Quick Reference

| Exception                             | When to throw                                        | Example                                |
| ------------------------------------- | ---------------------------------------------------- | -------------------------------------- |
| `AppException`                        | Generic app error not covered by subtypes            | Unexpected state in a use case         |
| `NoInternetException`                 | No network connectivity detected                     | Connectivity check returns false       |
| `DatabaseNotInitializedException`     | DB instance is `null` when accessed                  | `authenticatedInstance` not opened yet |
| `DatabaseOpenException`               | `Isar.open()` call fails                             | Disk full, migration error             |
| `DatabaseReadException`               | Query or read operation fails                        | Isar query throws                      |
| `DatabaseWriteException`              | Put/update/delete fails                              | Write transaction throws               |
| `DatabaseCloseException`              | `instance.close()` fails                             | Lock held by another isolate           |
| `CacheException`                      | SharedPreferences or in-memory cache operation fails | `prefs.setString()` throws             |
| `InvalidStateException`               | Operation attempted on uninitialized/invalid object  | Controller not initialized             |
| `MultipleAccountLimitExceedException` | User exceeds account limit                           | Server returns limit error             |

---

## Usage Patterns

### 1. Throwing Exceptions

#### Basic AppException

```dart
throw AppException(
  message: 'Unexpected condition in feature X',
  name: 'FeatureXUseCase',
  type: 'UNEXPECTED_CONDITION',
);
```

#### Database Exceptions

```dart
// In DbManager when Isar.open() fails
try {
  authenticatedInstance = await Isar.open(schemas, directory: dir);
} catch (e, st) {
  throw DatabaseOpenException(
    instanceName: 'USER-$userId',
    error: e,
    stackTrace: st,
  );
}

// In a Db class when instance is null
Isar? get _db => DbManager().authenticatedInstance;

Future<List<ChatFolder>> getAll() async {
  final db = _db;
  if (db == null) {
    throw DatabaseNotInitializedException(instanceName: 'authenticatedInstance');
  }
  try {
    return db.chatFolders.where().findAll();
  } catch (e, st) {
    throw DatabaseReadException(
      message: 'Failed to query chat folders',
      name: 'ChatFolderDb.getAll',
      error: e,
      stackTrace: st,
    );
  }
}
```

#### Cache Exception

```dart
try {
  await prefs.setString('auth_token', token);
} catch (e, st) {
  throw CacheException(
    message: 'Failed to save auth token',
    name: 'TokenCacheService',
    error: e,
    stackTrace: st,
  );
}
```

#### Invalid State

```dart
if (!_isInitialized) {
  throw InvalidStateException(
    message: 'Controller must be initialized before use',
    name: 'ChatFolderController',
  );
}
```

---

### 2. Catching Exceptions

#### Rule: Catch Specific-to-General

Always order catch clauses from most specific to least specific:

```dart
try {
  await chatFolderDb.getAll();
} on DatabaseNotInitializedException {
  // DB not ready — return empty or skip gracefully
  return [];
} on DatabaseReadException catch (e) {
  // Read failed — log and return cached data
  _log.e(e.toString());
  return _cachedFolders;
} on DatabaseException catch (e) {
  // Any other DB error
  _log.e('DB error', e.originalError, e.originalStackTrace);
  rethrow;
} on AppException catch (e) {
  // Any app-level error
  _log.e(e.toString());
  rethrow;
}
```

#### Using ExceptionHandler for Unknown Errors

```dart
try {
  await riskyOperation();
} catch (e) {
  final typed = ExceptionHandler.handle(e);
  // `typed` is always a known Exception subtype
  // Unknown errors are wrapped as AppException(type: 'UNKNOWN_ERROR')
}
```

---

### 3. Wrapping Low-Level Errors

Use `originalError` and `originalStackTrace` to preserve the root cause:

```dart
try {
  await isar.writeTxn(() async {
    await collection.put(entity);
  });
} catch (e, st) {
  throw DatabaseWriteException(
    message: 'Failed to save room entity',
    name: 'RoomDb.saveRoom',
    error: e,
    stackTrace: st,
  );
}
```

This preserves the full error chain for debugging while giving callers a typed exception they can pattern-match on.

---

### 4. Presentation Layer Handling

In controllers, use `handleException` for user-facing errors:

```dart
Future<void> loadFolders() async {
  try {
    folders.value = await _getFoldersUseCase.execute();
  } on DatabaseNotInitializedException {
    // Silently skip — DB will be ready on next attempt
  } on AppException catch (e) {
    handleException(e);
  }
}
```

---

## Best Practices

### DO

- **Throw typed exceptions** — use the most specific subtype available
- **Preserve root cause** — always pass `originalError` and `originalStackTrace`
- **Catch specific-to-general** — put specific catches before generic ones
- **Use `name` field** — include the class/method name for log context
- **Fail fast in DB layer** — throw `DatabaseNotInitializedException` instead of using `!`

### DON'T

- **Don't swallow errors silently** — always log or rethrow

  ```dart
  // BAD ❌
  } catch (e) {
    // silently ignored
  }

  // GOOD ✅
  } catch (e, st) {
    _log.e('Operation failed', e, st);
    throw DatabaseWriteException(message: '...', name: '...', error: e, stackTrace: st);
  }
  ```

- **Don't use force-unwrap (`!`) on DB instances** — use null-safe pattern:

  ```dart
  // BAD ❌
  Isar get dbInstance => DbManager().authenticatedInstance!;

  // GOOD ✅
  Isar? get _db => DbManager().authenticatedInstance;
  ```

- **Don't throw raw `Exception('...')`** — always use a typed subclass
- **Don't catch `Exception` when you can catch a specific type**

---

## Adding New Exception Types

1. **Create the class** in `lib/core/exceptions/` extending `AppException` or a subtype
2. **Add dartdoc** with description, when-to-throw, and usage example
3. **Export** it in `lib/core/exceptions/exceptions.dart`
4. **Register** it in `ExceptionHandler.handle()` if it needs special handling
5. **Write tests** mirroring the source path in `test/core/exceptions/`

### Template

````dart
/// Thrown when [describe condition].
///
/// ## When this happens
/// - [scenario 1]
/// - [scenario 2]
///
/// ## How to handle
/// ```dart
/// try {
///   // operation
/// } on MyNewException catch (e) {
///   // handle
/// }
/// ```
class MyNewException extends AppException {
  MyNewException({
    required super.message,
    super.name,
    Object? error,
    StackTrace? stackTrace,
  }) : super(
          type: 'MY_NEW_ERROR',
          originalError: error,
          originalStackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('MyNewException');
    if (name != null) buffer.write(' [$name]');
    buffer.write(': $message');
    if (originalError != null) buffer.write(' | caused by: $originalError');
    return buffer.toString();
  }
}
````

---

## File Locations

| File                                                               | Purpose                                       |
| ------------------------------------------------------------------ | --------------------------------------------- |
| `lib/core/exceptions/app_exception.dart`                           | Base class + DB/Cache/State exceptions        |
| `lib/core/exceptions/exceptions.dart`                              | Barrel file exporting all exceptions          |
| `lib/core/exceptions/exception_handler.dart`                       | Normalizes unknown errors to typed exceptions |
| `lib/core/exceptions/multiple_account_limit_exceed_exception.dart` | Account limit exception                       |
| `lib/core/exceptions/api_exception.dart`                           | API error base class                          |
| `lib/core/exceptions/socket_*.dart`                                | Socket-related exceptions                     |
| `docs/core/app_exception_guide.md`                                 | This guide                                    |

---

## Migration from Unsafe Patterns

### Before (unsafe — causes crashes)

```dart
class ChatFolderDb {
  Isar get dbInstance => DbManager().authenticatedInstance!; // ❌ Crash if null

  Future<List<ChatFolder>> getAll() async {
    try {
      return await dbInstance.chatFolders.where().findAll();
    } catch (e) {
      // ❌ Error swallowed silently
      return [];
    }
  }
}
```

### After (safe — with typed exceptions)

```dart
class ChatFolderDb {
  Isar? get _db => DbManager().authenticatedInstance; // ✅ Null-safe

  Future<List<ChatFolder>> getAll() async {
    final db = _db;
    if (db == null) return []; // or throw DatabaseNotInitializedException
    try {
      return await db.chatFolders.where().findAll();
    } catch (e, st) {
      throw DatabaseReadException(
        message: 'Failed to read chat folders',
        name: 'ChatFolderDb.getAll',
        error: e,
        stackTrace: st,
      );
    }
  }
}
```

---

## ExceptionHandler Resolution Order

`ExceptionHandler.handle()` checks types in this order:

1. `ApiException` → return as-is
2. `SocketIOException` → return as-is
3. `FailedHostLookupException` → return as-is
4. `DatabaseException` (and subtypes) → return as-is
5. `CacheException` → return as-is
6. `AppException` (and subtypes like `NoInternetException`, `InvalidStateException`) → return as-is
7. **Unknown** → wrap in `AppException(type: 'UNKNOWN_ERROR')`

This means you should **always** use `ExceptionHandler.handle()` at catch boundaries where you don't know the error type, ensuring all downstream code receives typed exceptions.
