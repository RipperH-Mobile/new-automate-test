import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'new_message_effect_feature_flag_model.g.dart';

@embedded
class NewMessageEffectFeatureFlagModel implements FeatureFlagInterface {
  @override
  bool? enabled;
  bool? animation;
  bool? sound;

  NewMessageEffectFeatureFlagModel({
    this.enabled,
    this.animation,
    this.sound,
  });

  static NewMessageEffectFeatureFlagModel fromMap(Map<String, dynamic> json) {
    return NewMessageEffectFeatureFlagModel(
      enabled: json['enabled'],
      animation: json['animation'],
      sound: json['sound'],
    );
  }

  @override
  String toString() {
    return '[NewMessageEffectFeatureFlagModel] enabled: $enabled,'
        ' animation: $animation'
        ' sound: $sound';
  }
}
