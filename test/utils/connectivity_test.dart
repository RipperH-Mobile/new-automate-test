import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/http/http_heartbeat.dart';
import 'package:uchat/api/socket/socket_heartbeat.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/connectivity_controller.dart';

// -------- Mock Classes --------
class MockSocketCaller extends Mock implements SocketCaller {}

class MockHttpCaller extends Mock implements HttpCaller {}

class MockSocketHeartbeat extends Mock implements SocketHeartbeat {}

class MockHttpHeartbeat extends Mock implements HttpHeartbeat {}

final getIt = GetIt.instance;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;

  late ConnectivityController controller;
  late MockSocketCaller mockSocketCaller;
  late MockHttpCaller mockHttpCaller;
  late MockSocketHeartbeat mockSocketHeartbeat;
  late MockHttpHeartbeat mockHttpHeartbeat;

  setUp(() {
    // Create mocks
    mockSocketCaller = MockSocketCaller();
    mockHttpCaller = MockHttpCaller();
    mockSocketHeartbeat = MockSocketHeartbeat();
    mockHttpHeartbeat = MockHttpHeartbeat();

    // Mock getters
    when(() => mockSocketCaller.heartbeat).thenReturn(mockSocketHeartbeat);
    when(() => mockHttpCaller.heartbeat).thenReturn(mockHttpHeartbeat);

    // Inject mocks via GetX
    getIt.registerSingleton<SocketCaller>(mockSocketCaller);
    getIt.registerSingleton<HttpCaller>(mockHttpCaller);

    // Create controller
    controller = ConnectivityController();

    controller.setConnectivityResultForTest([ConnectivityResult.wifi]);
  });

  tearDown(() {
    getIt.reset(); // Reset GetIt after each test
  });

  test('should set offline when http successRate = 0 and socket packetLoss = 1.0', () {
    controller.setConnectivityResultForTest([ConnectivityResult.none]);

    when(() => mockHttpHeartbeat.successRate).thenReturn(0.0);
    when(() => mockSocketCaller.isConnected).thenReturn(true);
    when(() => mockSocketHeartbeat.packetLossRate).thenReturn(1.0);

    controller.handleCheckConnectionQuality();

    expect(controller.connectivityStatus, ConnectivityStatus.offline);
  });

  test('should set unstable when http successRate < 0.95', () {
    controller.setConnectivityResultForTest([ConnectivityResult.wifi]);

    when(() => mockHttpHeartbeat.successRate).thenReturn(0.5);
    when(() => mockSocketCaller.isConnected).thenReturn(true);
    when(() => mockSocketHeartbeat.packetLossRate).thenReturn(0.0);

    controller.handleCheckConnectionQuality();

    expect(controller.connectivityStatus, ConnectivityStatus.unstable);
  });

  test('should set slow when latency > 4000', () {
    controller.setConnectivityResultForTest([ConnectivityResult.wifi]);

    when(() => mockHttpHeartbeat.successRate).thenReturn(1.0);
    when(() => mockHttpHeartbeat.averageLatency).thenReturn(5000);
    when(() => mockSocketCaller.isConnected).thenReturn(true);
    when(() => mockSocketHeartbeat.packetLossRate).thenReturn(0.0);
    when(() => mockSocketHeartbeat.averageLatency).thenReturn(100);

    controller.handleCheckConnectionQuality();

    expect(controller.connectivityStatus, ConnectivityStatus.slow);
  });

  test('should set online when everything normal', () {
    when(() => mockHttpHeartbeat.successRate).thenReturn(1.0);
    when(() => mockHttpHeartbeat.averageLatency).thenReturn(100);
    when(() => mockSocketCaller.isConnected).thenReturn(true);
    when(() => mockSocketHeartbeat.packetLossRate).thenReturn(0.0);
    when(() => mockSocketHeartbeat.averageLatency).thenReturn(100);

    controller.handleCheckConnectionQuality();

    expect(controller.connectivityStatus, ConnectivityStatus.online);
  });
}
