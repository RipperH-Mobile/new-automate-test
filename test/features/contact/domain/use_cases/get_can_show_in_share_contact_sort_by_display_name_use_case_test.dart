import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_can_show_in_share_contact_sort_by_display_name_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late GetCanShowInShareContactSortByDisplayNameUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    // Register fallback values for any complex types that might be used as arguments
    // For example, if ContactEntity was used as an argument to a mocked method:
    // registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = GetCanShowInShareContactSortByDisplayNameUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetCanShowInShareContactSortByDisplayNameUseCase', () {
    final tContactList = [
      ContactEntity(
        id: '1',
        displayName: 'Alice',
        email: 'alice@example.com',
        phoneNumber: '1234567890',
      ),
      ContactEntity(
        id: '2',
        displayName: 'Bob',
        email: 'bob@example.com',
        phoneNumber: '0987654321',
      ),
    ];

    test(
      'Given repository returns a list of contacts, When use case is called, Then returns the list of contacts',
      () async {
        // Given
        when(() => mockContactLocalRepository.getCanShowInShareContactSortByDisplayName())
            .thenAnswer((_) async => tContactList);

        // When
        final result = await useCase(NoParams());

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.getCanShowInShareContactSortByDisplayName()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () async {
        // Given
        final tException = Exception('Something went wrong');
        when(() => mockContactLocalRepository.getCanShowInShareContactSortByDisplayName())
            .thenThrow(tException);

        // When
        final call = useCase(NoParams());

        // Then
        await expectLater(call, throwsA(tException));
        verify(() => mockContactLocalRepository.getCanShowInShareContactSortByDisplayName()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}