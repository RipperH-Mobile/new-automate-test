import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/auth_login_response.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/enabled_features_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/entities/models/premium_package_model.dart';

void main() {
  group('AuthLoginResponse', () {
    // Note: We do NOT test fromMap here due to complex nested deserialization.
    // Nested models should have their own unit tests for fromMap.
    // This test focuses on constructor correctness only.
    test('Given all parameters, When instantiated, Then fields are assigned correctly', () {
      final enabledFeatures = EnabledFeaturesModel();
      final accountSettings = AccountSettingsModel();
      final premiumPackage = PremiumPackageModel();
      final linkAccounts = LinkAccountsModel();

      final response = AuthLoginResponse(
        success: true,
        id: 'user123',
        displayName: 'John Doe',
        birthDate: '1990-01-01',
        email: 'john@example.com',
        hasPassword: true,
        statusMessage: 'Hello',
        username: 'johndoe',
        phoneNumber: '1234567890',
        token: 'token123',
        avatarId: 'avatar123',
        avatarBlurhash: 'blurhash',
        background: 'bg',
        backgroundId: 'bg123',
        backgroundBlurhash: 'bgblur',
        lastEditUsernameAt: DateTime.now(),
        limitFriend: 200,
        friendRequestCount: 5,
        enabledFeatures: enabledFeatures,
        currentSessionKeyId: 'session123',
        onlineStatus: OnlineStatus.online,
        limitMultipleAccount: 3,
        maxChatFolder: 10,
        maxRoomInChatFolder: 50,
        accountSettings: accountSettings,
        purchaseRefId: 'ref123',
        premiumPackage: premiumPackage,
        uchatDefaultEmojiItems: [],
        accountDefaultEmojiItems: [],
        uchatDefaultBookmarkEmojiTags: [],
        accountDefaultBookmarkEmojiTags: [],
        linkAccounts: linkAccounts,
        isDeleted: false,
      );

      expect(response.success, true);
      expect(response.id, 'user123');
      expect(response.displayName, 'John Doe');
      expect(response.birthDate, '1990-01-01');
      expect(response.email, 'john@example.com');
      expect(response.hasPassword, true);
      expect(response.statusMessage, 'Hello');
      expect(response.username, 'johndoe');
      expect(response.phoneNumber, '1234567890');
      expect(response.token, 'token123');
      expect(response.avatarId, 'avatar123');
      expect(response.avatarBlurhash, 'blurhash');
      expect(response.background, 'bg');
      expect(response.backgroundId, 'bg123');
      expect(response.backgroundBlurhash, 'bgblur');
      expect(response.limitFriend, 200);
      expect(response.friendRequestCount, 5);
      expect(response.enabledFeatures, enabledFeatures);
      expect(response.currentSessionKeyId, 'session123');
      expect(response.onlineStatus, OnlineStatus.online);
      expect(response.limitMultipleAccount, 3);
      expect(response.maxChatFolder, 10);
      expect(response.maxRoomInChatFolder, 50);
      expect(response.accountSettings, accountSettings);
      expect(response.purchaseRefId, 'ref123');
      expect(response.premiumPackage, premiumPackage);
      expect(response.uchatDefaultEmojiItems, isEmpty);
      expect(response.accountDefaultEmojiItems, isEmpty);
      expect(response.uchatDefaultBookmarkEmojiTags, isEmpty);
      expect(response.accountDefaultBookmarkEmojiTags, isEmpty);
      expect(response.linkAccounts, linkAccounts);
      expect(response.isDeleted, false);
    });
  });
}