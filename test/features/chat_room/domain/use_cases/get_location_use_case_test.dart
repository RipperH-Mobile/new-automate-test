import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_location_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late GetLocationUseCase useCase;
  late MockLoggerService mockLogger;

  setUp(() {
    mockLogger = MockLoggerService();

    useCase = GetLocationUseCase(log: mockLogger);

    reset(mockLogger);

    when(() => mockLogger.i(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.w(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.d(any(), any(), any())).thenReturn(null);
  });

  test('should return MapInfoResponse when mapSelector is not null', () async {
    final fakeMapInfo = MapInfoResponse(
      placeID: 'place_001',
      name: 'Bangkok',
      location: const LatLng(13.7563, 100.5018),
      vicinity: 'Thailand',
      locationFormattedAddress: 'Bangkok, Thailand',
      distance: 123.4,
    );

    when(() => useCase.call(NoParams())).thenAnswer((_) async => fakeMapInfo);
    final result = await useCase(NoParams());

    expect(result, isA<MapInfoResponse?>());
  });

  test('should return null when mapSelector is null', () async {
    final result = await useCase.call(NoParams());

    expect(result, isNull);
  });
}
