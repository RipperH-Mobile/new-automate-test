import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/audio_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class UChatCallSystemAudio {
  factory UChatCallSystemAudio() => instance;

  UChatCallSystemAudio.internal();

  static final UChatCallSystemAudio instance = UChatCallSystemAudio.internal();

  Future<void> playEndCallSound() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (GetPlatform.isIOS) {
      try {
        await FlutterCallkitIncoming.playEndCallSound();
      } catch (e) {
        _log.w('iOS play dialing sound error.', e);
      }
    } else {
      try {
        await AudioController.to.playCallEndSound();
      } catch (e) {
        _log.w('iOS play dialing sound error.', e);
      }
    }
  }

  Future<void> playRingtoneSound() async {
    await Future.delayed(const Duration(seconds: 1));
    if (GetPlatform.isAndroid) {
      try {
        await AudioController.to.playRingtone();
      } catch (e, stackTrace) {
        _log.w('Android play dialing sound error.', e, stackTrace);
      }
    }
  }

  Future<void> playDialingSound() async {
    await Future.delayed(const Duration(seconds: 1));
    if (GetPlatform.isIOS) {
      try {
        await FlutterCallkitIncoming.playDialingSound();
      } catch (e) {
        _log.w('iOS play dialing sound error.', e);
      }
    } else {
      try {
        await AudioController.to.playDialingSound();
      } catch (e, stackTrace) {
        _log.w('Android play dialing sound error.', e, stackTrace);
      }
    }
  }

  Future<void> stopAllSounds() async {
    if (GetPlatform.isIOS) {
      try {
        await FlutterCallkitIncoming.stopAudioPlayer();
      } catch (e) {
        _log.w('iOS play dialing sound error.', e);
      }
    } else {
      try {
        await AudioController.to.stopCallEndSound();
      } catch (e, stackTrace) {
        _log.w('Android play dialing sound error.', e, stackTrace);
      }
      try {
        await AudioController.to.stopDialingSound();
      } catch (e, stackTrace) {
        _log.w('Android play dialing sound error.', e, stackTrace);
      }
      try {
        await AudioController.to.stopRingtone();
      } catch (e, stackTrace) {
        _log.w('Android play dialing sound error.', e, stackTrace);
      }
    }
  }
}
