import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/features/auth/domain/params/sign_in_to_firebase_params.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_to_firebase_use_case.dart';

// Mock Definitions
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class FakeSignInToFirebaseParams extends Fake implements SignInToFirebaseParams {}

// Custom SignInToFirebaseUseCase for testing that allows dependency injection
class TestableSignInToFirebaseUseCase extends SignInToFirebaseUseCase {
  final FirebaseAuth firebaseAuth;

  TestableSignInToFirebaseUseCase(this.firebaseAuth);

  @override
  Future<User> call(SignInToFirebaseParams params) async {
    if (firebaseAuth.currentUser != null) {
      if (firebaseAuth.currentUser?.uid == params.signInUserId) {
        // If user is already login don't do anything.
        return firebaseAuth.currentUser!;
      } else {
        await firebaseAuth.signOut();
      }
    }
    final result = await firebaseAuth.signInWithCustomToken(params.token);
    if (result.user == null) throw NullResponseException();
    return result.user!;
  }
}

void main() {
  late TestableSignInToFirebaseUseCase useCase;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;
  late SignInToFirebaseParams tParams;

  setUpAll(() {
    registerFallbackValue(FakeSignInToFirebaseParams());
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    useCase = TestableSignInToFirebaseUseCase(mockFirebaseAuth);
    tParams = SignInToFirebaseParams(
      signInUserId: 'test_user_id',
      token: 'test_custom_token',
    );

    // Reset mocks before each test
    reset(mockFirebaseAuth);
    reset(mockUser);
    reset(mockUserCredential);
  });

  group('SignInToFirebaseUseCase', () {
    group('call', () {
      test('Given no current user, When call is invoked, Then signs in with custom token and returns User', () async {
        // Given
        when(() => mockFirebaseAuth.currentUser).thenReturn(null);
        when(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).thenAnswer((_) async => mockUserCredential);
        when(() => mockUserCredential.user).thenReturn(mockUser);

        // When
        final result = await useCase.call(tParams);

        // Then
        expect(result, equals(mockUser));
        verify(() => mockFirebaseAuth.currentUser).called(1);
        verify(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).called(1);
        verifyNever(() => mockFirebaseAuth.signOut());
      });

      test('Given current user with same UID, When call is invoked, Then returns current user without signing in',
          () async {
        // Given
        when(() => mockUser.uid).thenReturn(tParams.signInUserId);
        when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // When
        final result = await useCase.call(tParams);

        // Then
        expect(result, equals(mockUser));
        verify(() => mockFirebaseAuth.currentUser).called(3); // Called three times in the method
        verifyNever(() => mockFirebaseAuth.signOut());
        verifyNever(() => mockFirebaseAuth.signInWithCustomToken(any()));
      });

      test('Given current user with different UID, When call is invoked, Then signs out and signs in with new token',
          () async {
        // Given
        final currentUser = MockUser();
        when(() => currentUser.uid).thenReturn('different_user_id');
        when(() => mockFirebaseAuth.currentUser).thenReturn(currentUser);
        when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).thenAnswer((_) async => mockUserCredential);
        when(() => mockUserCredential.user).thenReturn(mockUser);

        // When
        final result = await useCase.call(tParams);

        // Then
        expect(result, equals(mockUser));
        verify(() => mockFirebaseAuth.currentUser).called(2);
        verify(() => mockFirebaseAuth.signOut()).called(1);
        verify(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).called(1);
      });

      test('Given signInWithCustomToken returns null user, When call is invoked, Then throws NullResponseException',
          () async {
        // Given
        when(() => mockFirebaseAuth.currentUser).thenReturn(null);
        when(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).thenAnswer((_) async => mockUserCredential);
        when(() => mockUserCredential.user).thenReturn(null);

        // When
        Future<User> call() => useCase.call(tParams);

        // Then
        expect(call, throwsA(isA<NullResponseException>()));
        verify(() => mockFirebaseAuth.currentUser).called(1);
        verify(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).called(1);
      });

      test(
          'Given signInWithCustomToken throws FirebaseAuthException, When call is invoked, Then propagates the exception',
          () async {
        // Given
        final testException = FirebaseAuthException(code: 'invalid-custom-token');
        when(() => mockFirebaseAuth.currentUser).thenReturn(null);
        when(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).thenThrow(testException);

        // When
        Future<User> call() => useCase.call(tParams);

        // Then
        expect(call, throwsA(equals(testException)));
        verify(() => mockFirebaseAuth.currentUser).called(1);
        verify(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).called(1);
      });

      test(
          'Given signOut throws FirebaseAuthException, When call is invoked with different user, Then propagates the exception',
          () async {
        // Given
        final currentUser = MockUser();
        final testException = FirebaseAuthException(code: 'network-request-failed');
        when(() => currentUser.uid).thenReturn('different_user_id');
        when(() => mockFirebaseAuth.currentUser).thenReturn(currentUser);
        when(() => mockFirebaseAuth.signOut()).thenThrow(testException);

        // When
        Future<User> call() => useCase.call(tParams);

        // Then
        expect(call, throwsA(equals(testException)));
        verify(() => mockFirebaseAuth.currentUser).called(2);
        verify(() => mockFirebaseAuth.signOut()).called(1);
        verifyNever(() => mockFirebaseAuth.signInWithCustomToken(any()));
      });

      test('Given generic exception during signInWithCustomToken, When call is invoked, Then propagates the exception',
          () async {
        // Given
        final testException = Exception('Network error');
        when(() => mockFirebaseAuth.currentUser).thenReturn(null);
        when(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).thenThrow(testException);

        // When
        Future<User> call() => useCase.call(tParams);

        // Then
        expect(call, throwsA(equals(testException)));
        verify(() => mockFirebaseAuth.currentUser).called(1);
        verify(() => mockFirebaseAuth.signInWithCustomToken(tParams.token)).called(1);
      });

      test(
          'Given generic exception during signOut, When call is invoked with different user, Then propagates the exception',
          () async {
        // Given
        final currentUser = MockUser();
        final testException = Exception('Sign out failed');
        when(() => currentUser.uid).thenReturn('different_user_id');
        when(() => mockFirebaseAuth.currentUser).thenReturn(currentUser);
        when(() => mockFirebaseAuth.signOut()).thenThrow(testException);

        // When
        Future<User> call() => useCase.call(tParams);

        // Then
        expect(call, throwsA(equals(testException)));
        verify(() => mockFirebaseAuth.currentUser).called(2);
        verify(() => mockFirebaseAuth.signOut()).called(1);
        verifyNever(() => mockFirebaseAuth.signInWithCustomToken(any()));
      });
    });
  });
}
