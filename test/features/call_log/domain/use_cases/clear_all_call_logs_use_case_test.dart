import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_local_repository.dart';
import 'package:uchat/features/call_log/domain/repositories/call_log_server_repository.dart';
import 'package:uchat/features/call_log/domain/use_cases/clear_all_call_logs_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

class MockCallLogServerRepository extends Mock implements CallLogServerRepository {}

class MockCallLogLocalRepository extends Mock implements CallLogLocalRepository {}

void main() {
  late ClearAllCallLogsUseCase useCase;
  late MockCallLogServerRepository mockCallLogServerRepository;
  late MockCallLogLocalRepository mockCallLogLocalRepository;

  setUp(() {
    mockCallLogServerRepository = MockCallLogServerRepository();
    mockCallLogLocalRepository = MockCallLogLocalRepository();
    useCase = ClearAllCallLogsUseCase(
      callLogServerRepository: mockCallLogServerRepository,
      callLogLocalRepository: mockCallLogLocalRepository,
    );
  });

  group('call', () {
    test(
      'Given repositories are available, When use case is called, Then clears call logs from server and local repository',
      () async {
        // Given
        when(() => mockCallLogServerRepository.deleteCallLogs()).thenAnswer((_) async => 3);
        when(() => mockCallLogLocalRepository.clearCallLogs()).thenAnswer((_) async {});

        // When
        await useCase(NoParams());

        // Then
        verify(() => mockCallLogServerRepository.deleteCallLogs()).called(1);
        verify(() => mockCallLogLocalRepository.clearCallLogs()).called(1);
      },
    );

    test(
      'Given server repository throws exception, When use case is called, Then rethrows exception and does not clear local repository',
      () async {
        // Given
        when(() => mockCallLogServerRepository.deleteCallLogs()).thenThrow(Exception('server failed'));

        // When
        final action = useCase(NoParams());

        // Then
        await expectLater(action, throwsA(isA<Exception>()));
        verify(() => mockCallLogServerRepository.deleteCallLogs()).called(1);
        verifyNever(() => mockCallLogLocalRepository.clearCallLogs());
      },
    );
  });
}
