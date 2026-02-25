import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/domain/constants/native_method_names.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/entities/enum/audio_output_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/utils/screen_wake_lock_helper.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/call_system_audio.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/decline_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/decline_call_use_case.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/call/participant_info.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import 'uchat_livekit_abstract.dart';

enum CallConnectionType {
  accept,
  start,
  startGroup,
  joinGroup,
}

final _log = useLogger();

typedef AfterCallTask = void Function({dynamic error, StackTrace? st});

class UChatLiveKitController extends GetxController with WidgetsBindingObserver implements UChatLiveKitAbstract {
  final cameraOn = false.obs;
  final micOn = true.obs;
  final speakerOn = false.obs;
  final internetUnStable = false.obs;

  final Rx<RoomCallModel?> _callData = Rx(null);

  RoomCallModel get callData => _callData.value!;
  final isDisconnected = false.obs;

  set callData(RoomCallModel value) => _callData.value = value;

  set callState(CallState value) => _callData.update((val) => val?.callState = value);

  RxList<ParticipantTrack> otherParticipantList = RxList<ParticipantTrack>([]);
  RxList<RemoteParticipant> remoteParticipants = RxList<RemoteParticipant>([]);

  Room? room;
  EventsListener<RoomEvent>? listener;

  Rx<MediaDevice?> selectedVideoInput = Rx(null);
  Rx<MediaDevice?> selectedAudioInput = Rx(null);
  Rx<MediaDevice?> selectedAudioOutput = Rx(null);

  RxList<MediaDevice> audioInputs = RxList<MediaDevice>([]);
  RxList<MediaDevice> audioOutputs = RxList<MediaDevice>([]);
  RxList<MediaDevice> audioExternalOutputs = RxList<MediaDevice>([]);
  RxList<MediaDevice> videoInputs = RxList<MediaDevice>([]);

  StreamSubscription? _subscription;
  StreamSubscription? callDataSubscription;
  StreamSubscription? callUiStateSubscription;
  StreamSubscription<AudioSessionConfiguration>? configurationStream;
  StreamSubscription<AudioDevicesChangedEvent>? devicesChangedEventStream;

  bool get isVideoCall => callData.callType == CallType.video;

  UChatCallController get callCtl => Get.find<UChatCallController>();

  bool isEndCallPlayed = false;
  bool isStopAllSound = false;
  bool initialSpeaker = false;
  final isCameraFlipXAxis = false.obs;
  CameraPosition cameraPosition = CameraPosition.front;
  final status = 'Connecting...'.obs;
  final callDuration = '00:00'.obs;
  final isRecording = false.obs;
  bool callUiRefreshCheck = true;
  Timer? callTimer;
  bool isBackgroundExecutionEnabled = false;
  bool _wasCameraOnBeforePause = false;

  // DIRECT CALL
  final uiState = UiCallState.outgoing.obs;
  final liveKitReady = false.obs;
  final fullScreen = false.obs;

  final callingLiveKitConnecting = usePerformance().newTrace('calling-LiveKit-connecting');
  final callingMicrophoneConnecting = usePerformance().newTrace('calling-LiveKit-microphoneConnecting');
  final config = GetIt.I<ConfigDb>().authenticated;
  final enableWarMode = false.obs;
  final isShareScreen = false.obs;
  final localVideoTrackPublished = RxBool(Platform.isIOS);

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
  }

  String? getParticipantImage(Participant<TrackPublication<Track>>? pt) {
    if (pt?.metadata != null) {
      try {
        final json = jsonDecode(pt!.metadata!);
        if (json?['avatarId'] != null && json?['avatarId'].toString().isNotEmpty == true) {
          final id = json['avatarId'];
          final imageUrl = FileService.instance.getAvatarUrl(id);
          return imageUrl;
        }
      } catch (e, st) {
        _log.d('Error getParticipantImage: ', e, st);
      }
    }
    return null;
  }

  String? getParticipantBlurHash(Participant<TrackPublication<Track>>? pt) {
    if (pt?.metadata != null) {
      try {
        final json = jsonDecode(pt!.metadata!);
        if (json?['avatarBlurhash'] != null) {
          final blueHash = json['avatarBlurhash'];
          return blueHash;
        }
      } catch (e, st) {
        _log.d('Error getParticipantBlueHash: ', e, st);
      }
    }
    return null;
  }

  ParticipantTrackV2? localParticipant() {
    if (room?.localParticipant == null) {
      return null;
    }
    return ParticipantTrackV2(
      participant: room!.localParticipant!,
    );
  }

  ParticipantTrackV2? remoteParticipant(int index) {
    final participant = remoteParticipants.elementAtOrNull(index);
    if (participant == null) {
      return null;
    }
    return ParticipantTrackV2(
      participant: participant,
      type: participant.isScreenShareEnabled() ? ParticipantTrackType.kScreenShare : ParticipantTrackType.kUserMedia,
    );
  }

  // This is sorted participant list including local participant (index 0)
  // This list is used to show group call participant in call screen
  ParticipantTrackV2? otherParticipant(int index) {
    final participant = otherParticipantList.elementAtOrNull(index);
    if (participant == null) {
      return null;
    }
    return ParticipantTrackV2(
      participant: participant.participant,
      type: participant.isScreenShare ? ParticipantTrackType.kScreenShare : ParticipantTrackType.kUserMedia,
    );
  }

  UChatLiveKitController({
    required RoomCallModel callData,
  }) {
    _callData.value = callData;
    if (isVideoCall) {
      cameraOn(true);
      speakerOn(true);
    }
  }

  bool isParticipantOpenCamera() {
    final remote = remoteParticipant(0);
    if (remote == null) {
      return false;
    }
    RemoteTrackPublication<RemoteVideoTrack>? videoPublication = (remote.participant as RemoteParticipant)
        .videoTrackPublications
        .where((element) => element.source == remote.type.lkVideoSourceType)
        .firstOrNull;
    return (videoPublication?.track != null && videoPublication?.track?.muted == false) || cameraOn();
  }

  @override
  bool get isNotExisting => false;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    callingLiveKitConnecting.start();
    _loadWarModeConfig();
    super.onInit();
  }

  @override
  onReady() async {
    // await start();
    super.onReady();
  }

  @override
  void onClose() async {
    try {
      await stopAllSoundAndPlayEndCall();
    } catch (e, st) {
      _log.e('Error stop all sound: ', e, st);
    }

    try {
      await disposeCall();
    } catch (e, st) {
      _log.e('Error disposing call: ', e, st);
    }
    _callData.update((value) => value?.callState = CallState.disconnected);
    endAndroidForegroundService();
    await ScreenWakeLockHelper.disable();
    // android close display when use earpiece
    stopProximitySensor();
    configurationStream?.cancel();
    devicesChangedEventStream?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    callingLiveKitConnecting.stop();
    callingMicrophoneConnecting.stop();

    super.onClose();
  }

  @override
  Future<void> initialStartingUp() async {
    try {
      _subscription = Hardware.instance.onDeviceChange.stream.listen((List<MediaDevice> devices) async {
        onLoadDevices(devices);
      });
    } catch (e, st) {
      _log.e('Error Hardware stream listen: ', e, st);
    }

    try {
      callDataSubscription = _callData.stream.listen(roomDataListener);
    } catch (e, st) {
      _log.e('Error _callData stream listen: ', e, st);
    }

    try {
      callUiStateSubscription = uiState.stream.listen(callUiStateListener);
    } catch (e, st) {
      _log.e('Error uiState stream listen: ', e, st);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    _handleCameraLifecycleState(state: state);
  }

  void _handleAwakeDisplayAndroid(bool speakerOn) {
    if (!GetPlatform.isAndroid) return;

    if (speakerOn) {
      // android awake display when use speaker
      stopProximitySensor();
    } else {
      // android close display when use earpiece
      startProximitySensor();
    }
  }

  void stopProximitySensor() {
    if (GetPlatform.isAndroid) {
      GetIt.I<NativeMethodChannelService>().invokeMethod('stopProximitySensor');
    }
  }

  void startProximitySensor() {
    if (GetPlatform.isAndroid) {
      GetIt.I<NativeMethodChannelService>().invokeMethod('startProximitySensor');
    }
  }

  Future<void> setPreferSpeakerOutputHelper() async {
    try {
      if (GetPlatform.isAndroid) {
        await room?.setSpeakerOn(
          speakerOn() || cameraOn(),
        );
        _handleAwakeDisplayAndroid(speakerOn());
      } else {
        await room?.setSpeakerOn(
          speakerOn() || cameraOn(),
          forceSpeakerOutput: Hardware.instance.forceSpeakerOutput,
        );
      }
      _log.d('setPreferSpeakerOutputHelper: speakerOn: ${speakerOn()}');
    } catch (e, st) {
      _log.e('Error setSpeakerphoneOn: ', e, st);
    }
  }

  @override
  void roomDataListener(RoomCallModel? data) {}

  void callUiStateListener(UiCallState? data) {}

  @override
  void startCallTimer() {}

  Future<void> disposeCall() async {
    callTimer?.cancel();

    await ScreenWakeLockHelper.disable();
    await _subscription?.cancel();
    await callDataSubscription?.cancel();
    await callUiStateSubscription?.cancel();
    await liveKitCancelEventAndDisconnect();
  }

  Future<void> playDialingSound() async {
    if (isEndCallPlayed) return;
    try {
      await _handleAudioOutputAndroid(
        audioOutput: !isVideoCall ? AudioOutputType.earpiece : AudioOutputType.speaker,
      );
      await UChatCallSystemAudio.instance.playDialingSound();
    } catch (e, st) {
      _log.e('Error setting audio mode: ', e, st);
    }
    isStopAllSound = false;
  }

  Future<void> stopAllSoundAndPlayEndCall() async {
    if (isEndCallPlayed) return;
    isEndCallPlayed = true;
    isStopAllSound = true;
    try {
      await UChatCallSystemAudio.instance.stopAllSounds();
    } catch (e, st) {
      _log.e('Error stop all sound: ', e, st);
    }

    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await UChatCallSystemAudio.instance.playEndCallSound();
    } catch (e, st) {
      _log.e('Error stop all sound: ', e, st);
    }
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> connect<C extends UChatLiveKitController>() async {
    if (isDisconnected.value || isNotExisting) {
      return;
    }

    await startAndroidForegroundService();
    await ScreenWakeLockHelper.enable();

    if (callData.callType == CallType.voice) {
      // android close display when use earpiece
      startProximitySensor();
    }
    try {
      await createNewLiveKitRoom(callData.liveKitToken!);
    } catch (e, st) {
      _log.e('Error create LiveKit room: ', e, st);
      await errorHandler<C>(error: e, st: st);
      return;
    }
  }

  @override
  Future<void> disconnect<C extends UChatLiveKitController>(String reason) async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    debugPrint('Disconnecting call: $reason');

    if (isDisconnected.value) {
      return;
    }

    isDisconnected(true);
    callCtl.disconnecting(true);
    _callData.update((value) => value?.callState = CallState.disconnecting);

    stopAllSoundAndPlayEndCall();
    callCtl.callDuration.value = callDuration.value;

    await removeController<C>(
      callData,
      beforeRemoveTask: beforeRemoveTask,
      afterRemoveTask: afterRemoveTask,
    );
  }

  void openCallScreen<C extends UChatLiveKitController>() {
    callCtl.openCallScreen<C>(callData);
  }

  Future<void> errorHandler<C extends UChatLiveKitController>({dynamic error, StackTrace? st}) async {
    // if user disconnect before error unnecessary to show dialog.
    await removeController<C>(
      callData,
      beforeRemoveTask: isDisconnected.value ? null : beforeRemoveTask,
      afterRemoveTask: isDisconnected.value ? null : afterRemoveTask(error: error, st: st),
    );
  }

  Future<void> removeController<C extends UChatLiveKitController>(
    RoomCallModel callData, {
    Future<void> Function()? beforeRemoveTask,
    AfterCallTask? afterRemoveTask,
  }) async {
    await callCtl.removeCall<C>(
      callData,
      beforeRemoveTask: beforeRemoveTask,
      afterRemoveTask: afterRemoveTask,
    );
  }

  Future<void> beforeRemoveTask() async {
    try {
      final param = DeclineCallParam(
        roomCallModel: callData,
        isCancel: callData.callState != CallState.connected,
      );
      await GetIt.I<DeclineCallUseCase>().call(param);
    } catch (e, st) {
      _log.e('Error disposing call: ', e, st);
    }
    try {
      await stopAllSoundAndPlayEndCall();
    } catch (e, st) {
      _log.e('Error stop all sound: ', e, st);
    }
  }

  AfterCallTask? afterRemoveTask({dynamic error, StackTrace? st}) {
    callCtl.closeAnyCallScreen();
    if (error != null) {
      callCtl.showErrorDialog(
        error,
        st,
        description: error.toString(),
      );
    }
    return null;
  }

  Future<void> setMicFromCallKit({
    required bool isMuted,
  }) async {
    if (isMuted == !micOn()) {
      return;
    }
    GetIt.I<VibrateUtil>().vibrateSelection();
    if (isLiveKitConnected == false) {
      micOn(!isMuted);
      return;
    }
    EasyDebounce.debounce(
      'triggerCallMic',
      const Duration(milliseconds: 300),
      () async {
        micOn(!isMuted);
        await room?.localParticipant?.setMicrophoneEnabled(micOn());
      },
    );
  }

  Future<void> toggleMic({bool? value}) async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    if (isLiveKitConnected == false) {
      micOn.toggle();
      return;
    }
    EasyDebounce.debounce(
      'triggerCallMic',
      const Duration(milliseconds: 300),
      () async {
        if (value != null) {
          micOn(value);
        } else {
          micOn.toggle();
        }
        await toggleMicHelper();
      },
    );
  }

  Future<void> toggleMicHelper() async {
    if (GetPlatform.isIOS) {
      await FlutterCallkitIncoming.muteCall(
        callData.roomCallId!,
        isMuted: !micOn(),
      );
    }
    await room?.localParticipant?.setMicrophoneEnabled(micOn());
  }

  Future<void> toggleCamera({bool? value}) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.callSwitchedMode);
    GetIt.I<VibrateUtil>().vibrateSelection();

    if (isLiveKitConnected == false) {
      cameraOn.toggle();
      return;
    }

    if (value != null) {
      cameraOn(value);
    } else {
      cameraOn.toggle();
    }

    EasyDebounce.debounce(
      'triggerCallCamera',
      const Duration(milliseconds: 300),
      () async {
        await toggleCameraHelper();
      },
    );
  }

  Future<void> toggleCameraHelper() async {
    await room?.localParticipant?.setCameraEnabled(cameraOn());
    if (GetPlatform.isAndroid) {
      final bluetoothConnected = audioOutputs.any((e) => e.groupId?.toLowerCase().contains('bluetooth') == true);
      if (!bluetoothConnected) {
        await setPreferSpeakerOutputHelper();
        speakerOn(true);
      }
    } else if (GetPlatform.isIOS) {
      await setPreferSpeakerOutputHelper();
      speakerOn(true);
    }
  }

  Future<void> toggleSpeaker({
    bool? value,
    BuildContext? context,
    bool? isVideoMode,
  }) async {
    await GetIt.I<VibrateUtil>().vibrateSelection();
    if (cameraOn() && speakerOn()) {
      toggleSpeakerHelper(
        'toggleSpeaker',
        value: value,
        forceSpeakerOutput: false,
      );
      return;
    }
    if (value != null) {
      speakerOn(value);
    } else {
      speakerOn.toggle();
    }
    EasyDebounce.debounce(
      'triggerCallSpeaker',
      const Duration(milliseconds: 300),
      () async {
        toggleSpeakerHelper(
          'toggleSpeaker',
          value: value,
        );
      },
    );
  }

  Future<void> toggleSpeakerHelper(
    String debug, {
    bool? value,
    bool? forceSpeakerOutput,
  }) async {
    final speakerOn = value ?? this.speakerOn();
    this.speakerOn(speakerOn);

    _handleAwakeDisplayAndroid(speakerOn);

    room?.setSpeakerOn(
      speakerOn,
      forceSpeakerOutput: forceSpeakerOutput ?? (Hardware.instance.forceSpeakerOutput && !speakerOn),
    );
    await _handleAudioOutputAndroid(
      audioOutput: speakerOn ? AudioOutputType.speaker : AudioOutputType.earpiece,
    );
  }

  Future<void> switchCamera() async {
    GetIt.I<VibrateUtil>().vibrateSelection();

    EasyDebounce.debounce(
      'triggerCallCameraSwap',
      const Duration(milliseconds: 300),
      () async {
        final track = room?.localParticipant?.videoTrackPublications.firstOrNull?.track;
        if (track == null) return;

        try {
          final newPosition = cameraPosition.switched();
          _log.d('swapCamera: $newPosition');

          isCameraFlipXAxis(newPosition == CameraPosition.front);
          await track.setCameraPosition(newPosition);
          cameraPosition = newPosition;
        } catch (error) {
          _log.e('could not restart track by swapCamera: $error');
        }
      },
    );
  }

  void selectVideoInput(MediaDevice device) async {
    _log.d('call ctl :: >> [Video-Input] selectVideoInput >> ${device.deviceId}::${device.label}');
    try {
      final track = room?.localParticipant?.videoTrackPublications.firstOrNull?.track;
      if (track != null) {
        if (selectedVideoInput.value?.deviceId != device.deviceId) {
          await track.switchCamera(device.deviceId);
          selectedVideoInput.value = device;
        }
      } else {
        selectedVideoInput.value = device;
      }
    } catch (error, stackTrace) {
      _log.e('Could not switch camera', error, stackTrace);
    }
  }

  Future<void> loadDevices() async {
    if (Hardware.instance.forceSpeakerOutput == true) return;

    try {
      // TODO check `enumerateDevices` always use microphone permission active in macos.
      final mediaDevices = await Hardware.instance.enumerateDevices();
      onLoadDevices(mediaDevices);
    } catch (e, stackTrace) {
      _log.e('Cannot load media devices.', e, stackTrace);
    }
  }

  void onLoadDevices(List<MediaDevice> devices) {
    final previousAudioOutputs = audioOutputs.toList();
    final currentAudioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();

    _handleAndroidAudioOutputsChange(
      previousAudioOutputs: previousAudioOutputs,
      currentAudioOutputs: currentAudioOutputs,
    );

    audioInputs.value = devices.where((d) => d.kind == 'audioinput').toList();
    audioOutputs.value = currentAudioOutputs;
    videoInputs.value = devices.where((d) => d.kind == 'videoinput').toList();
    audioInputs.refresh();
    audioOutputs.refresh();
    videoInputs.refresh();
    initialExternalOutputDevice();
    _log.d('call ctl :: >> [Audio-Output] onLoadDevices >> ${audioOutputs.map((e) => '$e,').toList()}');
  }

  void initialExternalOutputDevice() {
    if (GetPlatform.isAndroid && selectedAudioOutput.value == null) {
      final bluetoothDevices = audioOutputs.firstWhereOrNull(
        (element) => ['speaker', 'receiver', 'earpiece', 'default'].contains((element.groupId!.toLowerCase())) == false,
      );
      if (bluetoothDevices != null) {
        selectedAudioOutput.value = bluetoothDevices;
        selectAudioOutput(bluetoothDevices);
      } else {
        setPreferSpeakerOutputHelper();
      }
    } else if (GetPlatform.isIOS) {
      setPreferSpeakerOutputHelper();
      selectedAudioOutput.value = null;
    }
  }

  Future<MediaDevice> selectAudioOutput(MediaDevice device) async {
    selectedAudioOutput.value = device;
    final audioOutput = AudioOutputType.fromMediaDevice(device);

    if (GetPlatform.isIOS) {
      if (audioOutput == AudioOutputType.earpiece) {
        audioOutputEarpieceManager();
        return selectedAudioOutput.value!;
      } else if (audioOutput == AudioOutputType.speaker) {
        audioOutputSpeakerManager();
        return selectedAudioOutput.value!;
      } else {
        return selectedAudioOutput.value!;
      }
    } else if (GetPlatform.isAndroid) {
      await Hardware.instance.selectAudioOutput(device);
      await _handleAudioOutputAndroid(audioOutput: audioOutput);
      if (audioOutput == AudioOutputType.speaker || audioOutput == AudioOutputType.earpiece) {
        speakerOn(audioOutput == AudioOutputType.speaker);
      }
    } else {
      await Hardware.instance.selectAudioOutput(device);
    }

    return selectedAudioOutput.value!;
  }

  Future<void> audioOutputEarpieceManager() async {
    if (cameraOn()) {
      // AVAudioSessionMode.voiceChat
      await toggleSpeakerHelper('audioOutputEarpieceManager cameraOn true', value: false, forceSpeakerOutput: false);
    } else {
      await toggleSpeakerHelper('audioOutputEarpieceManager cameraOn false', value: false);
    }
  }

  Future<void> audioOutputSpeakerManager() async {
    await toggleSpeakerHelper('audioOutputSpeakerManager ', value: true, forceSpeakerOutput: true);
  }

  Future<void> createNewLiveKitRoom(String token) async {
    String uri = AppEnv.socketLiveKit;

    // create new room
    room = Room(
      roomOptions: const RoomOptions(
        // asCallChatSession: (callType() == 'VOICE'),
        adaptiveStream: true,
        dynacast: true,
        defaultAudioCaptureOptions: AudioCaptureOptions(
          noiseSuppression: true,
          echoCancellation: true,
          autoGainControl: true,
          highPassFilter: true,
          typingNoiseDetection: true,
        ),
        defaultAudioPublishOptions: AudioPublishOptions(
          audioBitrate: AudioPreset.speech,
          // stopMicTrackOnMute: false,
        ),
        defaultVideoPublishOptions: VideoPublishOptions(simulcast: true),
        defaultCameraCaptureOptions: CameraCaptureOptions(maxFrameRate: 60),
        defaultScreenShareCaptureOptions: ScreenShareCaptureOptions(useiOSBroadcastExtension: true),
      ),
    );

    // Create a Listener before connecting
    listener = room?.createListener();
    // Try to connect to the room
    // This will throw an Exception if it fails for any reason.
    // await initialMic();

    await room?.connect(
      uri,
      token,
      connectOptions: const ConnectOptions(
          // timeouts: Timeouts(
          //   connection: Duration(seconds: 6),
          //   debounce: Duration(seconds: 6),
          //   peerConnection: Duration(seconds: 6),
          //   iceRestart: Duration(seconds: 6),
          //   publish: Duration(seconds: 6),
          // ),
          ),
      fastConnectOptions: FastConnectOptions(
        microphone: const TrackOption(enabled: true),
        camera: TrackOption(enabled: cameraOn()),
      ),
      // enableEarpieceAudio: !isVideoCall,
    );
    callingLiveKitConnecting.stop();
    callingMicrophoneConnecting.start();
  }

  void onEnableScreenShare() async {
    if (lkPlatformIsDesktop()) {
      try {
        final source = await showDialog(
          context: Get.context!,
          builder: (context) => ScreenSelectDialog(),
        );
        if (source == null) {
          debugPrint('cancelled screenshare');
          return;
        }
        debugPrint('DesktopCapturerSource: ${source.id}');
        final track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(
            sourceId: source.id,
            maxFrameRate: 15.0,
          ),
        );
        await room!.localParticipant!.publishVideoTrack(track);
      } catch (e) {
        debugPrint('could not publish video: $e');
      }
      return;
    }
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      final hasCapturePermission = await Helper.requestCapturePermission();
      if (!hasCapturePermission) {
        return;
      }

      requestBackgroundPermission([bool isRetry = false]) async {
        // Required for android screenshare.
        try {
          bool hasPermissions = await FlutterBackground.hasPermissions;
          if (!isRetry) {
            const androidConfig = FlutterBackgroundAndroidConfig(
              notificationTitle: 'Screen Sharing',
              notificationText: 'LiveKit Example is sharing the screen.',
              notificationImportance: AndroidNotificationImportance.normal,
              notificationIcon: AndroidResource(name: 'livekit_ic_launcher', defType: 'mipmap'),
            );
            hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
          }
          if (hasPermissions && !FlutterBackground.isBackgroundExecutionEnabled) {
            await FlutterBackground.enableBackgroundExecution();
          }
        } catch (e) {
          if (!isRetry) {
            return await Future<void>.delayed(const Duration(seconds: 1), () => requestBackgroundPermission(true));
          }
          debugPrint('could not publish video: $e');
        }
      }

      await requestBackgroundPermission();
    }
    if (lkPlatformIsWebMobile()) {
      await UChatDialogV3.showDefaultDialog(
          context: Get.context!, description: 'Screen share is not supported on mobile web');
      return;
    }
    if (lkPlatformIs(PlatformType.iOS)) {
      // for iOS without broadcast extension
      // if you want to use broadcast extension set `useiOSBroadcastExtension` to true
      // TODO: implement iOS screen share with broadcast extension (able to share inactive app screen)
      // https://github.com/livekit/client-sdk-flutter/issues/828
      // https://github.com/AoEiuV020/client-sdk-flutter/commit/8ae9b72f0fcf870a7aa47adb2c49a83c55ec4a6a
      // https://github.com/livekit/client-sdk-flutter/issues/585
      // https://github.com/flutter-webrtc/flutter-webrtc/wiki/iOS-Screen-Sharing
      var track = await LocalVideoTrack.createScreenShareTrack(
        const ScreenShareCaptureOptions(
          useiOSBroadcastExtension: false,
          maxFrameRate: 15.0,
        ),
      );
      await room!.localParticipant!.publishVideoTrack(track);
      isShareScreen(true);
      return;
    }
    await room!.localParticipant!.setScreenShareEnabled(
      true,
      captureScreenAudio: true,
      screenShareCaptureOptions: const ScreenShareCaptureOptions(
        useiOSBroadcastExtension: true,
      ),
    );
    isShareScreen(true);
  }

  void onDisableScreenShare() async {
    await room!.localParticipant!.setScreenShareEnabled(false);
    isShareScreen(false);

    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      try {
        //   await FlutterBackground.disableBackgroundExecution();
      } catch (error) {
        debugPrint('error disabling screen share: $error');
      }
    }
  }

  Future<void> liveKitCancelEventAndDisconnect() async {
    room?.removeListener(onRoomDidUpdate);
    try {
      await room?.disconnect();
    } catch (e, st) {
      _log.e('call ctl :: >> LiveKit disconnect error: ', e, st);
    }
    try {
      await listener?.cancelAll();
    } catch (e, st) {
      _log.e('call ctl :: >> cancelAll error: ', e, st);
    }
    try {
      await listener?.dispose();
    } catch (e, st) {
      _log.e('call ctl :: >> LiveKit listener dispose error: ', e, st);
    }
    try {
      await room?.dispose();
    } catch (e, st) {
      _log.e('call ctl :: >> LiveKit dispose error: ', e, st);
    }
    liveKitReady(false);
  }

  bool get isLiveKitConnected {
    return room != null && listener != null && room?.isDisposed == false && listener?.listeners.isNotEmpty == true;
  }

  @override
  void onActiveSpeakersChangedEvent(ActiveSpeakersChangedEvent event) {
    // TODO: implement onActiveSpeakersChangedEvent
  }

  @override
  void onDataReceivedEvent(DataReceivedEvent event) {
    // คนรับ
    // TODO: implement onDataReceivedEvent
  }

  @override
  void onLocalTrackPublishedEvent(LocalTrackPublishedEvent event) {
    // TODO: implement onLocalTrackPublishedEvent
    if (event.publication.track is LocalAudioTrack) {
      micOn(true);
      callingMicrophoneConnecting.stop();
    } else if (event.publication.track is LocalVideoTrack && !localVideoTrackPublished()) {
      localVideoTrackPublished(true);
    }

    sortParticipants();
  }

  @override
  void onLocalTrackUnpublishedEvent(LocalTrackUnpublishedEvent event) {
    // TODO: implement onLocalTrackUnpublishedEvent
    sortParticipants();
  }

  @override
  void onParticipantConnectedEvent(ParticipantConnectedEvent event) {
    // TODO: implement onParticipantConnectedEvent
    sortParticipants();
  }

  @override
  void onParticipantConnectionQualityUpdatedEvent(ParticipantConnectionQualityUpdatedEvent event) {
    if (!localVideoTrackPublished()) {
      localVideoTrackPublished(true);
    }
  }

  @override
  void onParticipantDisconnectedEvent(ParticipantDisconnectedEvent event) {
    // TODO: implement onParticipantDisconnectedEvent
  }

  @override
  void onRoomAttemptReconnectEvent(RoomAttemptReconnectEvent event) {
    // TODO: implement onRoomAttemptReconnectEvent
  }

  @override
  void onRoomDidUpdate() async {
    liveKitReady(true);
    if (isDisconnected.value || isNotExisting) {
      try {
        await disposeCall();
      } catch (e, st) {
        _log.e('Error disposing call: ', e, st);
      }
    }

    if (!initialSpeaker && (room?.activeSpeakers ?? []).isNotEmpty) {
      initialExternalOutputDevice();
      initialSpeaker = true;
    }
    sortParticipants();
  }

  @override
  void onRoomDisconnectedEvent(RoomDisconnectedEvent event) async {
    String callType = callData.callType == CallType.video ? 'video' : 'voice';
    String reason;
    switch (event.reason) {
      case DisconnectReason.unknown:
        reason = 'unknown';
        break;
      case DisconnectReason.clientInitiated:
      case DisconnectReason.duplicateIdentity:
      case DisconnectReason.participantRemoved:
      case DisconnectReason.roomDeleted:
      case DisconnectReason.stateMismatch:
        reason = 'crash';
        break;
      case DisconnectReason.serverShutdown:
      case DisconnectReason.joinFailure:
      case DisconnectReason.signalingConnectionFailure:
      case DisconnectReason.reconnectAttemptsExceeded:
        reason = 'network error';
        break;
      default:
        reason = 'normal';
        break;
    }
    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.callEnded, eventProperties: EventProperty.callEnded(callType, reason));

    await ScreenWakeLockHelper.disable();

    // START: POC End call from LiveKit (fallback case)
    // In case socket disconnect or any error that cause the call to end.
    // App close or socket is not connected.
    disconnect('LiveKit disconnect: ${event.reason?.name}');
    try {
      debugPrint('call FlutterCallkitIncoming to end call: LiveKit event');
      await FlutterCallkitIncoming.endCall(callData.roomCallId!);
    } catch (e) {
      _log.e('call ctl :: >> end call error', e);
    }
    // END: POC End call from LiveKit
  }

  @override
  void onTrackMutedEvent(TrackMutedEvent event) {
    // TODO: implement onTrackMutedEvent
    sortParticipants();
  }

  @override
  void onTrackSubscribedEvent(TrackSubscribedEvent event) async {
    // คนรอสาย
    // TODO: implement onTrackSubscribedEvent
    sortParticipants();
  }

  @override
  void onTrackUnmutedEvent(TrackUnmutedEvent event) {
    // TODO: implement onTrackUnmutedEvent
    sortParticipants();
  }

  @override
  void setUpStartCallListeners() {
    if (listener != null) {
      listener!
        ..on<AudioVisualizerEvent>((a) {
          _log.d('AudioVisualizerEvent: 123/${a.event.map((e) => ((e as num) * 100).toDouble()).toList()}');
        })
        ..on<ParticipantConnectionQualityUpdatedEvent>(onParticipantConnectionQualityUpdatedEvent)
        ..on<RoomAttemptReconnectEvent>(onRoomAttemptReconnectEvent)
        ..on<TrackUnmutedEvent>(onTrackUnmutedEvent)
        ..on<TrackMutedEvent>(onTrackMutedEvent)
        ..on<TrackSubscribedEvent>(onTrackSubscribedEvent)
        ..on<ActiveSpeakersChangedEvent>(onActiveSpeakersChangedEvent)
        ..on<RoomDisconnectedEvent>(onRoomDisconnectedEvent)
        ..on<LocalTrackPublishedEvent>(onLocalTrackPublishedEvent)
        ..on<LocalTrackUnpublishedEvent>(onLocalTrackUnpublishedEvent)
        ..on<ParticipantConnectedEvent>(onParticipantConnectedEvent)
        ..on<DataReceivedEvent>(onDataReceivedEvent)
        ..on<ParticipantDisconnectedEvent>(onParticipantDisconnectedEvent);
    }
  }

  @override
  void sortParticipants({event}) {
    List<ParticipantTrack> userMediaTracks = [];
    List<ParticipantTrack> screenTracks = [];
    final List<RemoteParticipant>? rawParticipantList = room?.remoteParticipants.values.toList();
    remoteParticipants(rawParticipantList);
    for (var participant in remoteParticipants) {
      // fixed participant no track when the participant initial without video.
      if (participant.videoTrackPublications.isEmpty) {
        userMediaTracks.add(ParticipantTrack(
          participant: participant,
          isScreenShare: false,
          videoTrack: null,
        ));
      } else {
        for (var t in participant.videoTrackPublications) {
          if (t.isScreenShare) {
            screenTracks.add(ParticipantTrack(
              participant: participant,
              videoTrack: t.track,
              isScreenShare: true,
            ));
          } else {
            userMediaTracks.add(ParticipantTrack(
              participant: participant,
              videoTrack: t.track,
              isScreenShare: false,
            ));
          }
        }
      }
    }
    if (userMediaTracks.length > (callCtl.isCallFloatingScreenShouldShow ? 1 : 3)) {
      // if (userMediaTracks.isEmpty) {
      //   pinedId.value = room?.localParticipant?.identity ?? '';
      // }
      DateTime now = DateTime.now();
      userMediaTracks.sort((pa, pb) {
        // last spoken at
        final a = pa.participant;
        final b = pb.participant;
        const tenSec = Duration(seconds: 10);
        const spNull = Duration(minutes: 999);

        DateTime aTime = a.lastSpokeAt ?? now.subtract(spNull);
        DateTime bTime = b.lastSpokeAt ?? now.subtract(spNull);

        bool aWithin10Seconds = aTime.isAfter(now.subtract(tenSec));
        bool bWithin10Seconds = bTime.isAfter(now.subtract(tenSec));

        if (aWithin10Seconds && !bWithin10Seconds) {
          return -1;
        } else if (!aWithin10Seconds && bWithin10Seconds) {
          return 1;
        } else if (aWithin10Seconds && bWithin10Seconds) {
          return a.joinedAt.compareTo(b.joinedAt);
        } else {
          if (a.videoTrackPublications.firstOrNull?.muted != b.videoTrackPublications.firstOrNull?.muted) {
            if (!(a.videoTrackPublications.firstOrNull?.muted ?? true)) {
              return -1;
            } else {
              return 1;
            }
          }
        }
        return bTime.compareTo(aTime);
      });
    }
    final localParticipantTracks = room?.localParticipant?.videoTrackPublications;
    if (localParticipantTracks != null) {
      if (localParticipantTracks.isEmpty) {
        userMediaTracks.insert(
          0,
          ParticipantTrack(
            participant: room!.localParticipant!,
            isScreenShare: false,
            videoTrack: null,
          ),
        );
      } else {
        for (var t in localParticipantTracks) {
          if (t.isScreenShare) {
            screenTracks.insert(
              0,
              ParticipantTrack(
                participant: room!.localParticipant!,
                videoTrack: t.track,
                isScreenShare: true,
              ),
            );
          } else {
            userMediaTracks.insert(
              0,
              ParticipantTrack(
                participant: room!.localParticipant!,
                videoTrack: t.track,
                isScreenShare: false,
              ),
            );
          }
        }
      }
    }
    otherParticipantList([...screenTracks, ...userMediaTracks]);
    otherParticipantList.refresh();
    remoteParticipants.refresh();
  }

  Future<void> startAndroidForegroundService() async {
    // please check AndroidManifest.xml android:name="de.julianassmann.flutter_background.IsolateHolderService"
    // foregroundServiceType="permission_type"
    // app crash if permission_type denied
    // please check permission granted
    try {
      if (GetPlatform.isAndroid) {
        if (FlutterBackground.isBackgroundExecutionEnabled == true) {
          _log.w('background execution already enabled');
          return;
        }
        final androidConfig = const FlutterBackgroundAndroidConfig(
          notificationTitle: 'UChat Call',
          notificationText: 'In Call..',
          showBadge: false,
          shouldRequestBatteryOptimizationsOff: false,
          notificationImportance: AndroidNotificationImportance.normal,
          notificationIcon: AndroidResource(
            name: 'background_icon',
            defType: 'drawable',
          ), // Default is ic_launcher from folder mipmap
        );
        bool success = await FlutterBackground.initialize(androidConfig: androidConfig);
        if (!success) {
          _log.w('could not enable background execution');
          return;
        }
        bool success2 = await FlutterBackground.enableBackgroundExecution();
        if (!success2) {
          _log.w('could not enable background execution');
        }
      }
    } catch (e, st) {
      _log.w('could not enable background execution error', e, st);
    }
  }

  Future<void> endAndroidForegroundService() async {
    try {
      if (GetPlatform.isAndroid && FlutterBackground.isBackgroundExecutionEnabled == true) {
        bool success = await FlutterBackground.disableBackgroundExecution();
        if (!success) {
          _log.w('could not enable background execution');
        }
      }
    } catch (e, st) {
      _log.w('could not enable background execution error', e, st);
    }
  }

  Future<void> _handleCameraLifecycleState({
    required AppLifecycleState state,
  }) async {
    if (state == AppLifecycleState.resumed && _wasCameraOnBeforePause) {
      cameraOn(true);
      await room?.localParticipant?.setCameraEnabled(true);
      return;
    }

    if (state == AppLifecycleState.paused) {
      _wasCameraOnBeforePause = cameraOn.value;

      if (!cameraOn.value) return;

      cameraOn(false);
      await room?.localParticipant?.setCameraEnabled(false);
      return;
    }
  }

  void _handleAndroidAudioOutputsChange({
    required List<MediaDevice> previousAudioOutputs,
    required List<MediaDevice> currentAudioOutputs,
  }) {
    if (!GetPlatform.isAndroid) {
      return;
    }

    final previousDeviceIds = previousAudioOutputs.map((d) => d.deviceId).toSet();
    final currentDeviceIds = currentAudioOutputs.map((d) => d.deviceId).toSet();

    if (previousDeviceIds.length == currentDeviceIds.length && previousDeviceIds.containsAll(currentDeviceIds)) {
      return;
    }

    selectedAudioOutput.value = null;
  }

  Future<void> _handleAudioOutputAndroid({
    required AudioOutputType audioOutput,
  }) async {
    if (!GetPlatform.isAndroid) return;

    final String methodName;
    switch (audioOutput) {
      case AudioOutputType.bluetooth:
        methodName = NativeMethodNames.androidCallModeBluetooth;
        break;
      case AudioOutputType.earpiece:
        methodName = NativeMethodNames.androidCallModeEarpiece;
        break;
      case AudioOutputType.speaker:
        methodName = NativeMethodNames.androidCallModeSpeaker;
        break;
    }
    await GetIt.I<NativeMethodChannelService>().invokeMethod(methodName);
  }
}
