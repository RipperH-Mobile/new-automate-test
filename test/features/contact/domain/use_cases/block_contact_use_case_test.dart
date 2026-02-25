import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/params/expire_all_secret_chat_with_account_id_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/expire_all_secret_chat_with_account_id_use_case.dart';
import 'package:uchat/features/contact/data/models/requests/block_contact_request.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';

class MockContactServerRepository extends Mock implements ContactServerRepository {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class MockExpireAllSecretChatWithAccountIdUseCase extends Mock implements ExpireAllSecretChatWithAccountIdUseCase {}

class FakeBlockContactRequest extends Fake implements BlockContactRequest {}

class FakeExpireAllSecretChatWithAccountIdParams extends Fake implements ExpireAllSecretChatWithAccountIdParams {}

void main() {
  late BlockContactUseCase useCase;
  late MockContactServerRepository mockContactRepo;
  late MockExpireAllSecretChatWithAccountIdUseCase mockExpireChatUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeBlockContactRequest());
    registerFallbackValue(FakeExpireAllSecretChatWithAccountIdParams());
  });

  setUp(() {
    mockContactRepo = MockContactServerRepository();
    mockExpireChatUseCase = MockExpireAllSecretChatWithAccountIdUseCase();
    mockContactLocalRepository = MockContactLocalRepository();

    useCase = BlockContactUseCase(
      contactServerRepository: mockContactRepo,
      contactLocalRepository: mockContactLocalRepository,
    );

    GetIt.I.registerSingleton<ExpireAllSecretChatWithAccountIdUseCase>(mockExpireChatUseCase);
  });

  tearDown(() {
    GetIt.I.unregister<ExpireAllSecretChatWithAccountIdUseCase>();
  });

  final tParams = BlockContactParams(contactIds: ['friend1', 'friend2']);

  group('BlockContactUseCase', () {
    test(
      'GIVEN a request to block contacts, WHEN repository calls are successful, THEN should complete and expire secret chats',
      () async {
        // GIVEN
        when(() => mockContactRepo.blockContact(any())).thenAnswer((_) async {
          return null;
        });
        when(() => mockExpireChatUseCase.call(any())).thenAnswer((_) async {});

        // WHEN
        await useCase(tParams);

        // THEN
        verify(() => mockContactRepo.blockContact(any(
            that: isA<BlockContactRequest>()
                .having((r) => r.friendAccountIds, 'friendAccountIds', tParams.contactIds)))).called(1);

        for (final id in tParams.contactIds) {
          verify(() => mockExpireChatUseCase.call(
                  any(that: isA<ExpireAllSecretChatWithAccountIdParams>().having((p) => p.accountId, 'accountId', id))))
              .called(1);
        }

        verifyNoMoreInteractions(mockContactRepo);
        verifyNoMoreInteractions(mockExpireChatUseCase);
      },
    );

    test(
      'GIVEN a request to block contacts, WHEN blockContact throws an exception, THEN should throw and not expire chats',
      () async {
        // GIVEN
        final tException = Exception('Failed to block');
        when(() => mockContactRepo.blockContact(any())).thenThrow(tException);

        // WHEN
        final call = useCase(tParams);

        // THEN
        await expectLater(() => call, throwsA(tException));

        verify(() => mockContactRepo.blockContact(any())).called(1);
        verifyNever(() => mockExpireChatUseCase.call(any()));
        verifyNoMoreInteractions(mockContactRepo);
        verifyNoMoreInteractions(mockExpireChatUseCase);
      },
    );
  });
}
