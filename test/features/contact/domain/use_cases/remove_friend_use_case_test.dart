import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/remove_friend_use_case.dart';

class MockContactServerRepository extends Mock implements ContactServerRepository {}

class FakeRemoveFriendRequest extends Fake implements RemoveFriendRequest {}

void main() {
  late RemoveFriendUseCase useCase;
  late MockContactServerRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeRemoveFriendRequest());
  });

  setUp(() {
    mockRepository = MockContactServerRepository();
    useCase = RemoveFriendUseCase(contactServerRepository: mockRepository);
  });

    final tRequest = RemoveFriendRequest(friendAccountId: 'friendId');

  group('RemoveFriendUseCase', () {
    test(
      'GIVEN a request to remove a friend, WHEN the repository returns true, THEN should return true',
      () async {
        // GIVEN
        when(() => mockRepository.removeFriend(any()))
            .thenAnswer((_) async => true);

        // WHEN
        final result = await useCase(tRequest);

        // THEN
        expect(result, true);
        verify(() => mockRepository.removeFriend(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'GIVEN a request to remove a friend, WHEN the repository returns false, THEN should return false',
      () async {
        // GIVEN
        when(() => mockRepository.removeFriend(any()))
            .thenAnswer((_) async => false);

        // WHEN
        final result = await useCase(tRequest);

        // THEN
        expect(result, false);
        verify(() => mockRepository.removeFriend(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'GIVEN a request to remove a friend, WHEN the repository throws an exception, THEN should throw the exception',
      () async {
        // GIVEN
        final tException = Exception('Failed to remove friend');
        when(() => mockRepository.removeFriend(any())).thenThrow(tException);

        // WHEN
        final call = useCase(tRequest);

        // THEN
        await expectLater(() => call, throwsA(tException));
        verify(() => mockRepository.removeFriend(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
