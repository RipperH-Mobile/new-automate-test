import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/unblock_contact_request.dart';
import 'package:uchat/features/contact/domain/params/unblock_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/unblock_contact_use_case.dart';

class MockContactServerRepository extends Mock implements ContactServerRepository {}

class FakeUnblockContactRequest extends Fake implements UnblockContactRequest {}

void main() {
  late UnblockContactUseCase useCase;
  late MockContactServerRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeUnblockContactRequest());
  });

  setUp(() {
    mockRepository = MockContactServerRepository();
    useCase = UnblockContactUseCase(contactServerRepository: mockRepository);
  });

  final tParams = UnblockContactParams(contactIds: ['friendId1', 'friendId2']);

  group('UnblockContactUseCase', () {
    test(
      'GIVEN a request to unblock contacts, WHEN the repository call is successful, THEN should complete successfully',
      () async {
        // GIVEN
        when(() => mockRepository.unblockContact(any()))
            .thenAnswer((_) async => Future.value());

        // WHEN
        final call = useCase(tParams);

        // THEN
        await expectLater(call, completes);
        verify(() => mockRepository.unblockContact(any(that: isA<UnblockContactRequest>()
              .having((r) => r.friendAccountIds, 'friendAccountIds', tParams.contactIds))))
            .called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'GIVEN a request to unblock contacts, WHEN the repository throws an exception, THEN should throw the exception',
      () async {
        // GIVEN
        final tException = Exception('Failed to unblock contacts');
        when(() => mockRepository.unblockContact(any())).thenThrow(tException);

        // WHEN
        final call = useCase(tParams);

        // THEN
        await expectLater(() => call, throwsA(tException));
        verify(() => mockRepository.unblockContact(any(that: isA<UnblockContactRequest>()
              .having((r) => r.friendAccountIds, 'friendAccountIds', tParams.contactIds))))
            .called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
