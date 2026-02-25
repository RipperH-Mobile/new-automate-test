import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models/call_kit_params_model.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/call/call_kit_incoming.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';

import 'call_controller.dart';
import 'data/data_source/remote/voip_http_service.dart';
import 'data/models/payloads/register_voip.dart';
import 'livekit/parent/uchat_livekit_controller.dart';

final _log = useLogger();

const testTypeConfigKey = 'CALL_TEST_TYPE';
const oneSignalUserIdConfigKey = 'CALL_ONE_SIGNAL_USER_ID';
const voipTokenConfigKey = 'CALL_VOIP_TOKEN';

class UChatCallNativeMethodChanel {
  factory UChatCallNativeMethodChanel() => instance;

  UChatCallNativeMethodChanel.internal();

  static final UChatCallNativeMethodChanel instance = UChatCallNativeMethodChanel.internal();

  ///
  /// Keep OneSignal ID for update in the future
  ///
  String? _oneSignalId;

  get oneSignalId => _oneSignalId;

  ///
  /// Keep Voip Token for checking update the OneSignal user
  ///
  String? _voipToken;

  get voipToken => _voipToken;

  ///
  /// Test type for call
  ///
  int _testType = 0;

  get testType => _testType;

  ///
  /// Initialize the call native method channel.
  /// For load previous data from local db.
  ///
  Future<void> initialize() async {
    // Set platform method handler
    GetIt.I<NativeMethodChannelService>().registerMethodCallHandlers({
      'callDisconnectEventChanel': (call) async {},
      'iosNativeStartCall': (call) async {
        startCallFromIOSIntent(call);
      },
      'callEventChannel': (call) async {
        Map<String, dynamic> argument = Map<String, dynamic>.from(call.arguments);
        final callData = RoomCallModel.fromMap(argument);
        callData.callConnectionType = CallConnectionType.accept;
        callData.callState = CallState.connected;
        final param = StartCallParam(
          callData: callData,
        );
        await GetIt.I<StartCallUseCase>().call(param);
      },
      'establishConnection': (call) async {},
      'updateVoipUser': (call) async {
        useLogger().d('CallNativeMethod => setPlatformMethodHandler updateVoipUser called');
        updateVoipUser(call.arguments);
      },
      'callKitIncomingCall': (call) async {
        Map<String, dynamic> argument = Map<String, dynamic>.from(call.arguments);
        openIncomingCall(argument);
      },
      'reportIncomingCall': (call) async {
        Map<String, dynamic> argument = Map<String, dynamic>.from(call.arguments);
        openIncomingCall(argument);
      },
      'iosNativeAudioOutputChange': (call) async {},
    });

    final config = ConfigDb();

    _oneSignalId = await config.authenticated.getString(key: oneSignalUserIdConfigKey);
    _voipToken = await config.authenticated.getString(key: voipTokenConfigKey);
  }

  UChatCallController get callCtl => Get.find<UChatCallController>();

  UserController get userCtl => UserController.instance;

  Future<void> triggerUpdateVoipUser() async {
    if (!GetPlatform.isIOS) return;
    useLogger().d('CallNativeMethod => triggerUpdateVoipUser called');
    await GetIt.I<NativeMethodChannelService>().invokeMethod('getVoipToken');
  }

  void startCallFromIOSIntent(call) async {
    try {
      Map<String, dynamic> argument = Map<String, dynamic>.from(call.arguments);
      String? calledFrom = argument['calledFrom']?.toString();
      String? handle = argument['handle']?.toString();
      String? roomId = handle?.split(',').elementAtOrNull(0);
      String? roomCallId = handle?.split(',').elementAtOrNull(1);
      bool isVideo = argument['isVideo'].toString() == 'true' || argument['isVideo'].toString() == '1';
      final roomDb = GetIt.I<RoomDb>();
      if (roomDb.dbInstance == null) {
        // TODO: Improved this, if app just start roomDbInstance is null
        // TODO: added future delayed solved it but should improve.
        await Future.delayed(const Duration(seconds: 3));
      }

      if (roomId == null || roomCallId == null) {
        // TODO: handle error native always send roomId and roomCallId null
        _log.e('ios_native_start_call_error: roomId or roomCallId is null ($handle)');
        return;
      }

      final roomData = await roomDb.getRoom(roomId);
      final callData = RoomCallModel.fromMap({
        'roomId': roomId,
        'roomCallId': roomCallId,
        'isVideo': isVideo,
        'callConnectionType': CallConnectionType.start,
        'callType': isVideo ? CallType.video : CallType.voice,
        'callState': CallState.idle,
        'callFrom': calledFrom,
        'roomName': roomData?.roomName,
        'roomType': roomData?.roomType,
        'roomAvatar': roomData?.roomAvatarUrl,
        'title': roomData?.roomName,
        'imageUrl': roomData?.roomAvatarUrl,
        'imageBlurhash': roomData?.photoBlurhash,
      });

      final param = StartCallParam(
        callData: callData,
      );
      await GetIt.I<StartCallUseCase>().call(param);
    } catch (e, stackTrace) {
      _log.w('error when calling iosNativeStartCall.', e, stackTrace);
    }
  }

  void openIncomingCall(argument) async {
    try {
      await UChatCallkitIncoming.instance.showCallkitIncoming(CallKitParamsModel.fromMap(argument));
    } catch (e, stackTrace) {
      _log.w('error when calling reportIncomingCall.', e, stackTrace);
    }
  }

  Future<void> updateVoipUser(String voipToken) async {
    final currentUser = userCtl.currentUser.value;
    if (currentUser == null) {
      _log.w('CallNativeMethod => updateVoipUser: currentUser is null');
      return;
    }

    final config = ConfigDb();

    // Check if userId and sessionKeyId are null
    final userId = currentUser.id;
    final sessionKeyId = currentUser.currentSessionKeyId;
    if (userId == null || sessionKeyId == null) {
      _log.w('CallNativeMethod => updateVoipUser: userId or sessionKeyId is null');
      return;
    }

    // Save Voip Token to config
    _log.d('CallNativeMethod => updateVoipUser called $voipToken');
    _voipToken = voipToken;
    await config.authenticated.saveConfig(
      key: voipTokenConfigKey,
      value: _voipToken,
    );

    try {
      // Get test type and set to config
      _testType = 0;
      if (userCtl.enableCallTestType == true) {
        _testType = 1;
      }

      // Save OneSignal ID to config
      await config.authenticated.saveConfig(
        key: testTypeConfigKey,
        value: testType,
      );

      // Create OneSignal user
      final response = await GetIt.I<VoipHttpService>().registerVoip(RegisterVoipRequest(
        voipToken: voipToken,
        testType: testType,
      ));
      if (response == null) {
        _log.w('CallNativeMethod => updateVoipUser: response is null');
        return;
      }

      _oneSignalId = response.oneSignalId;
      useLogger().d('CallNativeMethod => OneSignalId: $_oneSignalId');

      // Save OneSignal ID to config
      await config.authenticated.saveConfig(
        key: oneSignalUserIdConfigKey,
        value: oneSignalId,
      );
    } catch (e, stackTrace) {
      _log.w('error in updateVoipUser', e, stackTrace);
    }
  }

  ///
  /// Tool for remove OneSignal user
  ///
  Future<void> removeOneSignalUser() async {
    try {
      useLogger().d('CallNativeMethod => RemovingOnesignalUser: $_oneSignalId');
      final response = await GetIt.I<VoipHttpService>().deregisterVoip();
      if (response == null) {
        useLogger().w('CallNativeMethod => removeOneSignalUser: response is null');
        return;
      }

      if (response.oneSignalId != _oneSignalId) {
        useLogger().w('CallNativeMethod => removeOneSignalUser: OneSignalId is not equal');
        return;
      }

      // Remove OneSignal ID from config
      _oneSignalId = null;
      await ConfigDb().authenticated.saveConfig(
            key: oneSignalUserIdConfigKey,
            value: _oneSignalId,
          );
    } catch (e, stackTrace) {
      useLogger().e('CallNativeMethod => error in removeOneSignalUser', e, stackTrace);
    }
  }
}
