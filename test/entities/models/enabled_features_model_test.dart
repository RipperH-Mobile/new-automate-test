import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/entities/models/bookmark_feature_flag_model.dart';
import 'package:uchat/entities/models/call_feature_flag_model.dart';
import 'package:uchat/entities/models/chat_folder_feature_flag_model.dart';
import 'package:uchat/entities/models/enabled_features_model.dart';
import 'package:uchat/entities/models/feature_ability_pin_model.dart';
import 'package:uchat/entities/models/feature_ability_secret_room_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';
import 'package:uchat/entities/models/hold_chat_feature_flag_model.dart';
import 'package:uchat/entities/models/multiple_account_feature_flag_model.dart';
import 'package:uchat/entities/models/new_message_effect_feature_flag_model.dart';

void main() {
  group('EnabledFeaturesModel', () {
    test('Given no parameters, When EnabledFeaturesModel is instantiated, Then all fields are null', () {
      // When
      final model = EnabledFeaturesModel();

      // Then
      expect(model.bookmark, isNull);
      expect(model.call, isNull);
      expect(model.chatFolder, isNull);
      expect(model.chatFolderV2, isNull);
      expect(model.coin, isNull);
      expect(model.helpCenter, isNull);
      expect(model.holdChat, isNull);
      expect(model.lockMessage, isNull);
      expect(model.multipleAccount, isNull);
      expect(model.newMessage, isNull);
      expect(model.pin, isNull);
      expect(model.premiumStore, isNull);
      expect(model.previewFont, isNull);
      expect(model.reactMessage, isNull);
      expect(model.secretRoom, isNull);
      expect(model.talker, isNull);
      expect(model.troubleshoot, isNull);
      expect(model.uploadPro, isNull);
      expect(model.webhook, isNull);
      expect(model.debugAccount, isNull);
      expect(model.analytic, isNull);
      expect(model.groupPermission, isNull);
    });

    test('Given initial field values, When EnabledFeaturesModel is instantiated with parameters, Then fields are set correctly', () {
      // Given
      final coin = FeatureFlagBase(enabled: true);
      final pin = FeatureAbilityPinModel(enabled: true, maxPin: 5);

      // When
      final model = EnabledFeaturesModel(
        coin: coin,
        pin: pin,
      );

      // Then
      expect(model.coin, equals(coin));
      expect(model.pin, equals(pin));
      // Other fields should be null
      expect(model.bookmark, isNull);
      expect(model.call, isNull);
    });

    test('Given empty JSON map, When EnabledFeaturesModel.fromMap is called, Then all fields are null', () {
      // Given
      const json = <String, dynamic>{};

      // When
      final model = EnabledFeaturesModel.fromMap(json);

      // Then
      expect(model.bookmark, isNull);
      expect(model.call, isNull);
      expect(model.chatFolder, isNull);
      expect(model.chatFolderV2, isNull);
      expect(model.coin, isNull);
      expect(model.helpCenter, isNull);
      expect(model.holdChat, isNull);
      expect(model.lockMessage, isNull);
      expect(model.multipleAccount, isNull);
      expect(model.newMessage, isNull);
      expect(model.pin, isNull);
      expect(model.premiumStore, isNull);
      expect(model.previewFont, isNull);
      expect(model.reactMessage, isNull);
      expect(model.secretRoom, isNull);
      expect(model.talker, isNull);
      expect(model.troubleshoot, isNull);
      expect(model.uploadPro, isNull);
      expect(model.webhook, isNull);
      expect(model.debugAccount, isNull);
      expect(model.analytic, isNull);
      expect(model.groupPermission, isNull);
    });

    test('Given full JSON map, When EnabledFeaturesModel.fromMap is called, Then creates instance with all fields', () {
      // Given
      final json = <String, dynamic>{
        'bookmark': {'enabled': true},
        'call': {'enabled': true},
        'chatFolder': {'enabled': false},
        'chatFolderV2': {'enabled': true},
        'coin': {'enabled': true},
        'helpCenter': {'enabled': false},
        'holdChat': {'enabled': true},
        'lockMessage': {'enabled': false},
        'multipleAccount': {'enabled': true},
        'newMessageEffect': {'enabled': true},
        'pin': {'enabled': true, 'maxPin': 10},
        'premiumStore': {'enabled': false},
        'previewFont': {'enabled': true},
        'reactMessage': {'enabled': false},
        'secretRoom': {'enabled': true},
        'talker': {'enabled': false},
        'troubleshoot': {'enabled': true},
        'uploadPro': {'enabled': false},
        'webhook': {'enabled': true},
        'debugAccount': {'enabled': false},
        'analytic': {'enabled': true},
        'groupPermission': {'enabled': false},
      };

      // When
      final model = EnabledFeaturesModel.fromMap(json);

      // Then - verify that fromMap was called on each model
      expect(model.bookmark, isA<BookmarkFeatureFlagModel>());
      expect(model.call, isA<CallFeatureFlagModel>());
      expect(model.chatFolder, isA<ChatFolderFeatureFlagModel>());
      expect(model.chatFolderV2, isA<ChatFolderFeatureFlagModel>());
      expect(model.coin, isA<FeatureFlagBase>());
      expect(model.helpCenter, isA<FeatureFlagBase>());
      expect(model.holdChat, isA<HoldChatFeatureFlagModel>());
      expect(model.lockMessage, isA<FeatureFlagBase>());
      expect(model.multipleAccount, isA<MultipleAccountFeatureFlagModel>());
      expect(model.newMessage, isA<NewMessageEffectFeatureFlagModel>());
      expect(model.pin, isA<FeatureAbilityPinModel>());
      expect(model.premiumStore, isA<FeatureFlagBase>());
      expect(model.previewFont, isA<FeatureFlagBase>());
      expect(model.reactMessage, isA<FeatureFlagBase>());
      expect(model.secretRoom, isA<FeatureAbilitySecretRoomModel>());
      expect(model.talker, isA<FeatureFlagBase>());
      expect(model.troubleshoot, isA<FeatureFlagBase>());
      expect(model.uploadPro, isA<FeatureFlagBase>());
      expect(model.webhook, isA<FeatureFlagBase>());
      expect(model.debugAccount, isA<FeatureFlagBase>());
      expect(model.analytic, isA<FeatureFlagBase>());
      expect(model.groupPermission, isA<FeatureFlagBase>());
    });

    test('Given JSON map with null individual fields, When EnabledFeaturesModel.fromMap is called, Then handles null values correctly', () {
      // Given
      final json = <String, dynamic>{
        'bookmark': null,
        'call': {'enabled': true},
        'coin': null,
        'pin': {'enabled': true, 'maxPin': 5},
      };

      // When
      final model = EnabledFeaturesModel.fromMap(json);

      // Then
      expect(model.bookmark, isNull);
      expect(model.call, isA<CallFeatureFlagModel>());
      expect(model.coin, isNull);
      expect(model.pin, isA<FeatureAbilityPinModel>());
      expect(model.newMessage, isNull); // not in json
    });

    test('Given EnabledFeaturesModel instance, When toString is called, Then returns formatted string', () {
      // Given
      final model = EnabledFeaturesModel();

      // When
      final result = model.toString();

      // Then
      expect(result, startsWith('[EnabledFeatures]'));
      expect(result, contains('bookmark: null'));
      expect(result, contains('call: null'));
      expect(result, contains('chatFolder: null'));
      expect(result, contains('chatFolderV2: null'));
      expect(result, contains('coin: null'));
      expect(result, contains('groupPermission: null'));
    });

    test('Given EnabledFeaturesModel with non-null values, When toString is called, Then formats correctly', () {
      // Given
      final coin = FeatureFlagBase(enabled: true);
      final model = EnabledFeaturesModel(coin: coin);

      // When
      final result = model.toString();

      // Then
      expect(result, startsWith('[EnabledFeatures]'));
      expect(result, contains('coin: $coin'));
      expect(result, contains('bookmark: null'));
    });
  });
}