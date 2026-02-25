import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/unhide_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/unhide_contact_use_case.dart';

class MockContactServerRepository extends Mock implements ContactServerRepository {}

class FakeUnHideContactRequest extends Fake implements UnHideContactRequest {}

void main() {
  late UnhideContactUseCase useCase;
  late MockContactServerRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeUnHideContactRequest());
  });

  setUp(() {
    mockRepository = MockContactServerRepository();
    useCase = UnhideContactUseCase(contactServerRepository: mockRepository);
  });

    final tRequest = UnHideContactRequest(friendAccountIds: ['friendId']);

  group('UnhideContactUseCase',
      () {
    test(
      'GIVEN a request to unhide a contact, WHEN the repository call is successful, THEN should complete successfully',
      () async {
        // GIVEN
        when(() => mockRepository.unHideContact(any()))
            .thenAnswer((_) async => Future.value());

        // WHEN
        final call = useCase(tRequest);

        // THEN
        await expectLater(call, completes);
        verify(() => mockRepository.unHideContact(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'GIVEN a request to unhide a contact, WHEN the repository throws an exception, THEN should throw the exception',
      () async {
        // GIVEN
        final tException = Exception('Failed to unhide contact');
        when(() => mockRepository.unHideContact(any())).thenThrow(tException);

        // WHEN
        final call = useCase(tRequest);

        // THEN
        await expectLater(() => call, throwsA(tException));
        verify(() => mockRepository.unHideContact(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
