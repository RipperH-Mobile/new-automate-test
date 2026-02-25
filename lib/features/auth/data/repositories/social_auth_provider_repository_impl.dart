import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/services/social_auth_provider/apple_auth_service.dart';
import 'package:uchat/core/services/social_auth_provider/google_auth_service.dart';
import 'package:uchat/features/auth/data/models/enum/link_account_type.dart';
import 'package:uchat/features/auth/data/models/requests/sign_in_with_facebook_param.dart';
import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';

class SocialAuthProviderRepositoryImpl implements SocialAuthProviderRepository {
  SocialAuthProviderRepositoryImpl({
    required this.googleSignInService,
    required this.appleSignInService,
  });

  final GoogleAuthService googleSignInService;
  final AppleAuthService appleSignInService;

  @override
  Future<LinkAccountAuthEntity> signInWithApple() async {
    final credential = await appleSignInService.signIn();
    final token = credential.identityToken;

    if (token == null) {
      throw ExceptionHandler.handle('apple-id-token-null');
    }

    return LinkAccountAuthEntity(
      type: LinkAccountType.apple,
      token: token,
      email: credential.email ?? '',
    );
  }

  @override
  Future<LinkAccountAuthEntity> signInWithFacebook(SignInWithFacebookParam? param) async {
    // Android no permission tracking transparency required.
    // so let it pass

    // Apple review rejected, they are unable to locate the App Tracking Transparency permission request
    // So, we remove NSUserTrackingUsageDescription config for now
    // TODO: 1. add NSUserTrackingUsageDescription in Info.plist for iOS tracking permission
    // TODO: 2. at `ios/Podfile` set `PERMISSION_APP_TRACKING_TRANSPARENCY=1`
    // TODO: 3.1 also added App Privacy details in App Store Connect, App Store -> TRUST & SAFETY -> App Privacy
    // TODO: 3.2 Third Party Data -> Data Used to Track You -> Yes (for facebook sign in)
    throw Exception('Facebook sign-in is temporarily disabled.');

    final status = await Permission.appTrackingTransparency.request();
    if (status == PermissionStatus.granted || GetPlatform.isAndroid) {
      await FacebookAuth.i.autoLogAppEventsEnabled(true);
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final result = await FacebookAuth.instance.login(nonce: nonce, loginTracking: LoginTracking.enabled);
      final accessToken = result.accessToken;

      if (accessToken == null) {
        if (result.message == 'User has cancelled login with facebook') {
          throw NullResponseException('User-has-cancelled-login-with-facebook');
        }

        throw NullResponseException('facebook-access-token-null');
      }

      if (param?.isShowToast == true) {
        AppToast.showSyncToast(Get.context!);
      }

      final String tokenString = accessToken.tokenString;

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(tokenString);

      final data = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      final email = data.user?.email ?? '';
      final token = await data.user?.getIdToken() ?? '';

      return LinkAccountAuthEntity(
        type: LinkAccountType.facebook,
        token: token,
        email: email,
      );
    } else {
      if (status.isPermanentlyDenied) {
        throw NullResponseException('permanently-denied');
      }

      throw NullResponseException('facebook-access-token-null');
    }
  }

  @override
  Future<LinkAccountAuthEntity> signInWithGoogle() async {
    await googleSignInService.signIn();
    final googleAuth = await googleSignInService.getAuth();
    final user = googleSignInService.currentUser;
    final token = googleAuth?.idToken;

    if (token == null) {
      throw ExceptionHandler.handle('google-id-token-null');
    }

    return LinkAccountAuthEntity(
      type: LinkAccountType.google,
      token: token,
      email: user?.email ?? '',
    );
  }

  @override
  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  @override
  Future<void> signOutGoogle() async {
    await googleSignInService.signOut();
  }

  @override
  Future<void> unlinkWithApple() async {
    throw UnimplementedError();
  }

  @override
  Future<void> unlinkWithFacebook() async {
    throw UnimplementedError();
  }

  @override
  Future<void> unlinkWithGoogle() async {
    await googleSignInService.unlink();
  }

  String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
