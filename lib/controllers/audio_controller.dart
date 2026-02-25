import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';

// Audio Controller
AudioPlayer callDialingPlayer = AudioPlayer(playerId: 'call_dialing');
AudioContextConfig callDialingContextConfig = AudioContextConfig(
  // forceSpeaker: true,
  respectSilence: true,
);

AudioContextConfig getMessageContextConfig = AudioContextConfig(
  focus: AudioContextConfigFocus.duckOthers,
);

AudioPlayer getMessagePlayer = AudioPlayer(playerId: 'message_pop');
AudioPlayer callRingingPlayer = AudioPlayer(playerId: 'call_ringing');
AudioPlayer callTerminatePlayer = AudioPlayer(playerId: 'call_terminate');

const dialingAudioFileName = 'assets/audios/call/dialing.mp3';
const ringingAudioFileName = 'assets/audios/call/ringing.mp3';
const endCallAudioFileName = 'assets/audios/call/termination.mp3';
const getMessageMeFileName = 'assets/audios/message/pop_1.mp3';
const getMessageFriendFileName = 'assets/audios/message/pop_2.mp3';

class AudioController extends GetxController {
  final _log = useLogger();

  static AudioController get instance => Get.find<AudioController>();

  @Deprecated('Use AudioController.instance instead')
  static AudioController get to => Get.find();

  final playerMsgId = ''.obs;

  UserController? get userCtl {
    try {
      return Get.find<UserController>();
    } catch (_) {
      return null;
    }
  }

  bool audioPlaying = false;

  UserEntity? get user => userCtl?.currentUser();

  @override
  void onClose() {
    callDialingPlayer.dispose();
    callRingingPlayer.dispose();
    callTerminatePlayer.dispose();
    getMessagePlayer.dispose();
    super.onClose();
  }

  Future<void> setupAudioPlayer() async {
    try {
      AudioCache.instance = AudioCache(prefix: '');
      await Future.wait([
        callDialingPlayer.setSourceAsset(dialingAudioFileName),
        callRingingPlayer.setSourceAsset(ringingAudioFileName),
        callTerminatePlayer.setSourceAsset(endCallAudioFileName),
        getMessagePlayer.setSourceAsset(getMessageMeFileName),
        getMessagePlayer.setAudioContext(getMessageContextConfig.build()),
      ]);
    } catch (e, stackTrace) {
      _log.w('Error setup audio player', e, stackTrace);
    }
  }

  Future<void> playDialingSound() async {
    await callDialingPlayer.setReleaseMode(ReleaseMode.loop);
    await callDialingPlayer.play(AssetSource(dialingAudioFileName));
  }

  Future<void> playRingtone() async {
    await callRingingPlayer.setReleaseMode(ReleaseMode.loop);
    await callRingingPlayer.play(AssetSource(ringingAudioFileName));
  }

  Future<void> playCallEndSound() async {
    await callTerminatePlayer.setReleaseMode(ReleaseMode.stop);
    await callTerminatePlayer.play(AssetSource(endCallAudioFileName));
  }

  Future<void> stopRingtone() async {
    await callRingingPlayer.stop();
  }

  Future<void> stopDialingSound() async {
    await callDialingPlayer.stop();
  }

  Future<void> stopCallEndSound() async {
    await callTerminatePlayer.stop();
  }

  Future<void> playGetMessageSound(bool isMe) async {
    try {
      if (user == null || user?.isNewMessageSoundEnable != true) {
        return;
      }
      final String? fileName;
      if (isMe) {
        fileName = user?.newMessageSoundMeSelected;
      } else {
        fileName = user?.newMessageSoundFriendSelected;
      }
      if (audioPlaying) {
        return;
      }
      audioPlaying = true;
      await getMessagePlayer.setReleaseMode(ReleaseMode.stop);
      await getMessagePlayer.seek(Duration.zero);
      await getMessagePlayer.play(
        AssetSource(
          fileName ?? (isMe ? getMessageMeFileName : getMessageFriendFileName),
        ),
        volume: 0.7,
        mode: PlayerMode.lowLatency,
      );
    } catch (_) {
    } finally {
      audioPlaying = false;
    }
  }
}
