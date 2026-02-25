/// Base exception class for all in-app (non-API, non-socket) exceptions.
///
/// This serves as the root of the app-level exception hierarchy.
/// All custom exceptions that originate from within the app (not from
/// API responses or socket connections) should extend this class.
///
/// ## Exception Hierarchy Overview
///
/// ```
/// Exception (dart:core)
/// └── AppException (general in-app errors)
///     ├── NoInternetException         — device is offline / no connectivity
///     ├── DatabaseException           — base for all local DB errors
///     │   ├── DatabaseNotInitializedException — DB instance is null / not opened
///     │   ├── DatabaseOpenException           — Isar.open() failed
///     │   ├── DatabaseReadException           — query / read operation failed
///     │   ├── DatabaseWriteException          — put / update / delete failed
///     │   └── DatabaseCloseException          — close operation failed
///     ├── CacheException              — cache read/write failures
///     ├── InvalidStateException       — object in unexpected state
///     ├── MultipleAccountLimitExceedException — account limit reached
///     └── (future app-level exceptions)
/// ```
///
/// ## Usage
///
/// ### Throwing
/// ```dart
/// throw AppException(
///   message: 'Something went wrong',
///   name: 'FeatureX',
///   type: 'UNEXPECTED_STATE',
/// );
/// ```
///
/// ### Catching (specific to general)
/// ```dart
/// try {
///   await someOperation();
/// } on DatabaseNotInitializedException catch (e) {
///   // Handle DB not ready — e.g. skip operation gracefully
///   _log.w(e.toString());
/// } on DatabaseException catch (e) {
///   // Handle any DB error
///   _log.e(e.toString(), e, e.originalError as Object?);
/// } on AppException catch (e) {
///   // Handle any app-level error
///   _log.e(e.toString());
/// }
/// ```
///
/// ### With ExceptionHandler
/// ```dart
/// } catch (e) {
///   final typed = ExceptionHandler.handle(e);
///   // typed is always a known Exception subtype
/// }
/// ```
class AppException implements Exception {
  /// Human-readable error description.
  final String message;

  /// Optional identifier for the feature or component that threw.
  /// e.g. `'ChatFolderDb'`, `'AlbumUseCase'`
  final String? name;

  /// Optional machine-readable error type for programmatic handling.
  /// e.g. `'DATABASE_NOT_INITIALIZED'`, `'INVALID_PARAM'`
  final String? type;

  /// Optional original error that caused this exception.
  /// Useful for wrapping lower-level errors while preserving context.
  final Object? originalError;

  /// Optional original stack trace from the root cause.
  final StackTrace? originalStackTrace;

  AppException({
    required this.message,
    this.name,
    this.type,
    this.originalError,
    this.originalStackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('AppException');
    if (name != null) buffer.write(' [$name]');
    if (type != null) buffer.write(' ($type)');
    buffer.write(': $message');
    if (originalError != null) buffer.write(' | caused by: $originalError');
    return buffer.toString();
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Network Exceptions
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Thrown when the device has no internet connectivity.
///
/// Typically caught in the presentation layer to show an offline banner
/// or retry dialog.
///
/// ```dart
/// throw NoInternetException(message: 'No internet connection available');
/// ```
class NoInternetException extends AppException {
  NoInternetException({required super.message})
      : super(
          name: 'NoInternet',
          type: 'NO_INTERNET',
        );
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Database Exceptions
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Base exception for all local database (Isar) errors.
///
/// Catch this type to handle any DB-related failure generically.
/// For more specific handling, catch the subtypes instead.
///
/// ```dart
/// try {
///   await chatFolderDb.getAll();
/// } on DatabaseException catch (e) {
///   _log.e('DB operation failed', e.originalError, e.originalStackTrace);
/// }
/// ```
class DatabaseException extends AppException {
  DatabaseException({
    required super.message,
    super.name,
    super.originalError,
    super.originalStackTrace,
  }) : super(type: 'DATABASE_ERROR');

  @override
  String toString() {
    final buffer = StringBuffer('DatabaseException');
    if (name != null) buffer.write(' [$name]');
    buffer.write(': $message');
    if (originalError != null) buffer.write(' | caused by: $originalError');
    return buffer.toString();
  }
}

/// Thrown when code attempts to access a database instance that has not
/// been opened yet (i.e. `DbManager().authenticatedInstance` is null).
///
/// This is the fix for the `Null check operator used on a null value` crash
/// that occurs when Db classes use `authenticatedInstance!` before the
/// instance is ready.
///
/// ## When this happens
/// - `Isar.open()` failed silently and `authenticatedInstance` stayed null
/// - Code runs before `openAuthenticatedInstance()` completes
/// - A race condition in the orchestrator flow
///
/// ## How to handle
/// ```dart
/// try {
///   final folders = await chatFolderDb.getAll();
/// } on DatabaseNotInitializedException {
///   // DB not ready yet — return empty/default or retry later
///   return [];
/// }
/// ```
class DatabaseNotInitializedException extends DatabaseException {
  DatabaseNotInitializedException({
    String? instanceName,
  }) : super(
          message: 'Database instance${instanceName != null ? ' ($instanceName)' : ''} '
              'is not initialized. Ensure openAuthenticatedInstance() or '
              'openGeneralInstance() completed successfully before accessing the DB.',
          name: instanceName,
        );

  @override
  String toString() => 'DatabaseNotInitializedException: $message';
}

/// Thrown when `Isar.open()` fails during database initialization.
///
/// This wraps the original Isar error with context about which instance
/// was being opened.
///
/// ## How to handle
/// ```dart
/// try {
///   await DbManager().openAuthenticatedInstance(userId: userId);
/// } on DatabaseOpenException catch (e) {
///   _log.e('Cannot open DB', e.originalError, e.originalStackTrace);
///   // Show error to user or prevent downstream operations
/// }
/// ```
class DatabaseOpenException extends DatabaseException {
  DatabaseOpenException({
    required String instanceName,
    required Object error,
    StackTrace? stackTrace,
  }) : super(
          message: 'Failed to open database instance: $instanceName',
          name: instanceName,
          originalError: error,
          originalStackTrace: stackTrace,
        );

  @override
  String toString() => 'DatabaseOpenException [$name]: $message | caused by: $originalError';
}

/// Thrown when a database read/query operation fails.
///
/// ```dart
/// try {
///   return await collection.where().findAll();
/// } catch (e, st) {
///   throw DatabaseReadException(
///     message: 'Failed to query chat folders',
///     name: 'ChatFolderDb.getAll',
///     error: e,
///     stackTrace: st,
///   );
/// }
/// ```
class DatabaseReadException extends DatabaseException {
  DatabaseReadException({
    required super.message,
    super.name,
    required Object error,
    StackTrace? stackTrace,
  }) : super(
          originalError: error,
          originalStackTrace: stackTrace,
        );

  @override
  String toString() => 'DatabaseReadException [$name]: $message | caused by: $originalError';
}

/// Thrown when a database write (put/update/delete) operation fails.
///
/// ```dart
/// try {
///   await dbInstance.writeTxn(() async {
///     await collection.put(item);
///   });
/// } catch (e, st) {
///   throw DatabaseWriteException(
///     message: 'Failed to save chat folder',
///     name: 'ChatFolderDb.put',
///     error: e,
///     stackTrace: st,
///   );
/// }
/// ```
class DatabaseWriteException extends DatabaseException {
  DatabaseWriteException({
    required super.message,
    super.name,
    required Object error,
    StackTrace? stackTrace,
  }) : super(
          originalError: error,
          originalStackTrace: stackTrace,
        );

  @override
  String toString() => 'DatabaseWriteException [$name]: $message | caused by: $originalError';
}

/// Thrown when closing a database instance fails.
///
/// ```dart
/// try {
///   await authenticatedInstance?.close();
/// } catch (e, st) {
///   throw DatabaseCloseException(
///     instanceName: 'USER-$userId',
///     error: e,
///     stackTrace: st,
///   );
/// }
/// ```
class DatabaseCloseException extends DatabaseException {
  DatabaseCloseException({
    required String instanceName,
    required Object error,
    StackTrace? stackTrace,
  }) : super(
          message: 'Failed to close database instance: $instanceName',
          name: instanceName,
          originalError: error,
          originalStackTrace: stackTrace,
        );

  @override
  String toString() => 'DatabaseCloseException [$name]: $message | caused by: $originalError';
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Cache Exceptions
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Thrown when a cache operation (SharedPreferences, in-memory cache, etc.) fails.
///
/// Use this for non-DB local storage failures.
///
/// ```dart
/// try {
///   await prefs.setString('key', value);
/// } catch (e, st) {
///   throw CacheException(
///     message: 'Failed to save preference: key',
///     error: e,
///     stackTrace: st,
///   );
/// }
/// ```
class CacheException extends AppException {
  CacheException({
    required super.message,
    super.name,
    Object? error,
    StackTrace? stackTrace,
  }) : super(
          type: 'CACHE_ERROR',
          originalError: error,
          originalStackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('CacheException');
    if (name != null) buffer.write(' [$name]');
    buffer.write(': $message');
    if (originalError != null) buffer.write(' | caused by: $originalError');
    return buffer.toString();
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  State Exceptions
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Thrown when an operation is attempted on an object in an invalid state.
///
/// For example, trying to send a message when the user is not authenticated,
/// or accessing a controller that hasn't been initialized.
///
/// ```dart
/// if (!isInitialized) {
///   throw InvalidStateException(
///     message: 'Controller must be initialized before use',
///     name: 'ChatFolderController',
///   );
/// }
/// ```
class InvalidStateException extends AppException {
  InvalidStateException({
    required super.message,
    super.name,
  }) : super(type: 'INVALID_STATE');

  @override
  String toString() {
    final buffer = StringBuffer('InvalidStateException');
    if (name != null) buffer.write(' [$name]');
    buffer.write(': $message');
    return buffer.toString();
  }
}
