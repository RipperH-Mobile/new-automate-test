import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/data/repositories/user_local_repository_impl.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/entities/services/user_db.dart';

class MockUserDb extends Mock implements UserDb {}
class MockConfigInstance extends Mock implements ConfigInstance {}

void main() {
  late UserLocalRepositoryImpl repository;
  late MockUserDb mockUserDb;
  late MockConfigInstance mockConfigGeneral;

  setUp(() {
    mockUserDb = MockUserDb();
    mockConfigGeneral = MockConfigInstance();
    repository = UserLocalRepositoryImpl(
      userDb: mockUserDb,
      configGeneral: mockConfigGeneral,
    );
  });

  group('getUserCount', () {
    test('Given userDb returns count, When getUserCount is called, Then returns the count', () async {
      // Given
      when(() => mockUserDb.getUserCount()).thenAnswer((_) async => 5);
      
      // When
      final result = await repository.getUserCount();
      
      // Then
      expect(result, equals(5));
      verify(() => mockUserDb.getUserCount()).called(1);
    });

    test('Given userDb throws exception, When getUserCount is called, Then throws the exception', () async {
      // Given
      final exception = Exception('Database error');
      when(() => mockUserDb.getUserCount()).thenThrow(exception);
      
      // When
      final result = repository.getUserCount();

      // Then
      expect(() => result, throwsA(equals(exception)));
      verify(() => mockUserDb.getUserCount()).called(1);
    });
  });
}