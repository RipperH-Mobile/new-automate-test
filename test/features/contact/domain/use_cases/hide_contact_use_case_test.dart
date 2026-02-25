import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/hide_contact_use_case.dart';

class MockContactServerRepository extends Mock implements ContactServerRepository {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class FakeHideContactRequest extends Fake implements HideContactRequest {}

void main() {
  late HideContactUseCase useCase;
  late MockContactServerRepository mockRepository;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeHideContactRequest());
  });

  setUp(() {
    mockRepository = MockContactServerRepository();
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = HideContactUseCase(
      contactServerRepository: mockRepository,
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  final tRequest = HideContactRequest(friendAccountIds: ['friendId']);

  group('HideContactUseCase', () {
    test(
      'GIVEN a request to hide a contact, WHEN the repository call is successful, THEN should complete successfully',
      () async {
        // GIVEN
        when(() => mockRepository.hideContact(any())).thenAnswer((_) async => Future.value());

        // WHEN
        final call = useCase(tRequest);

        // THEN
        await expectLater(call, completes);
        verify(() => mockRepository.hideContact(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'GIVEN a request to hide a contact, WHEN the repository throws an exception, THEN should throw the exception',
      () async {
        // GIVEN
        final tException = Exception('Failed to hide contact');
        when(() => mockRepository.hideContact(any())).thenThrow(tException);

        // WHEN
        final call = useCase(tRequest);

        // THEN
        await expectLater(() => call, throwsA(tException));
        verify(() => mockRepository.hideContact(tRequest)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
