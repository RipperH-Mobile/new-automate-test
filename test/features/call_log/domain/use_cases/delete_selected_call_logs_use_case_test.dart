import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/features/call_log/domain/use_cases/delete_selected_call_logs_use_case.dart';

class MockCallLogServerRepository extends Mock implements CallLogServerRepository {}

class MockCallLogLocalRepository extends Mock implements CallLogLocalRepository {}

void main() {
  late DeleteSelectedCallLogsUseCase useCase;
  late MockCallLogServerRepository mockCallLogServerRepository;
  late MockCallLogLocalRepository mockCallLogLocalRepository;

  setUp(() {
    mockCallLogServerRepository = MockCallLogServerRepository();
    mockCallLogLocalRepository = MockCallLogLocalRepository();
    useCase = DeleteSelectedCallLogsUseCase(
      callLogServerRepository: mockCallLogServerRepository,
      callLogLocalRepository: mockCallLogLocalRepository,
    );
  });

  group('call', () {
    test(
      'Given valid call log IDs with duplicates and empties, When use case is called, Then sends unique non-empty IDs to both repositories',
      () async {
        // Given
        const inputIds = ['a', '', 'a', 'b'];
        when(
          () => mockCallLogServerRepository.deleteCallLogs(
            callLogIds: any(named: 'callLogIds'),
          ),
        ).thenAnswer((_) async => 2);
        when(() => mockCallLogLocalRepository.deleteAllCallLogs(any())).thenAnswer((_) async {});

        // When
        await useCase(inputIds);

        // Then
        final serverArgs = verify(
          () => mockCallLogServerRepository.deleteCallLogs(
            callLogIds: captureAny(named: 'callLogIds'),
          ),
        ).captured.single as List<String>;
        final localArgs =
            verify(() => mockCallLogLocalRepository.deleteAllCallLogs(captureAny())).captured.single as List<String>;

        expect(serverArgs, equals(['a', 'b']));
        expect(localArgs, equals(['a', 'b']));
      },
    );

    test(
      'Given only empty call log IDs, When use case is called, Then throws ArgumentError and does not call repositories',
      () async {
        // Given
        const inputIds = ['', ''];

        // When
        final action = useCase(inputIds);

        // Then
        await expectLater(action, throwsA(isA<ArgumentError>()));
        verifyNever(
          () => mockCallLogServerRepository.deleteCallLogs(
            callLogIds: any(named: 'callLogIds'),
          ),
        );
        verifyNever(() => mockCallLogLocalRepository.deleteAllCallLogs(any()));
      },
    );

    test(
      'Given server delete fails, When use case is called, Then rethrows error and does not delete local call logs',
      () async {
        // Given
        const inputIds = ['x'];
        when(
          () => mockCallLogServerRepository.deleteCallLogs(
            callLogIds: any(named: 'callLogIds'),
          ),
        ).thenThrow(Exception('server failed'));

        // When
        final action = useCase(inputIds);

        // Then
        await expectLater(action, throwsA(isA<Exception>()));
        verify(
          () => mockCallLogServerRepository.deleteCallLogs(
            callLogIds: any(named: 'callLogIds'),
          ),
        ).called(1);
        verifyNever(() => mockCallLogLocalRepository.deleteAllCallLogs(any()));
      },
    );
  });
}
