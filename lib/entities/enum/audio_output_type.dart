import 'package:livekit_client/livekit_client.dart';

enum AudioOutputType {
  earpiece,
  speaker,
  bluetooth;

  String get value {
    switch (this) {
      case AudioOutputType.earpiece:
        return 'EARPIECE';
      case AudioOutputType.speaker:
        return 'SPEAKER';
      case AudioOutputType.bluetooth:
        return 'BLUETOOTH';
    }
  }

  static AudioOutputType fromString(String? value) {
    switch (value) {
      case 'EARPIECE':
        return AudioOutputType.earpiece;
      case 'SPEAKER':
        return AudioOutputType.speaker;
      case 'BLUETOOTH':
        return AudioOutputType.bluetooth;
      default:
        return AudioOutputType.earpiece;
    }
  }

  static AudioOutputType fromMediaDevice(MediaDevice? device) {
    if (device == null || device.kind != 'audiooutput') {
      return AudioOutputType.earpiece;
    }

    final groupId = device.groupId?.toLowerCase();
    final isBluetooth = groupId?.contains('bluetooth') == true;
    final isEarpiece = ['earpiece', 'receiver'].contains(groupId);
    
    if (isBluetooth) {
      return AudioOutputType.bluetooth;
    } else if (isEarpiece) {
      return AudioOutputType.earpiece;
    } else {
      return AudioOutputType.speaker;
    }
  }
}
