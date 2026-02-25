import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/http/dio_extension.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/features/auth/data/models/requests/update_linking_account_with_social_request.dart';
import 'package:uchat/features/auth/data/models/responses/auth_login_response.dart';
import 'package:uchat/features/auth/data/models/responses/social_link_response.dart';

class SocialAuthApiService with ServiceMixin {
  final _log = useLogger();

  /// Singleton pattern
  static final SocialAuthApiService instance = SocialAuthApiService._internal();

  factory SocialAuthApiService() => instance;

  SocialAuthApiService._internal();

  Future<AuthLoginResponse?> signInWithGoogle(String token) async {
    final httpResp = await httpCaller.post(
      BackendPath.signInByGoogleAccount.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  Future<AuthLoginResponse?> signInWithApple(String token) async {
    final httpResp = await httpCaller.post(
      BackendPath.signInByAppleId.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  Future<AuthLoginResponse?> signInWithFacebook(String token) async {
    final httpResp = await httpCaller.post(
      BackendPath.signInByFacebookAccount.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  /// Get public key and private key of the current user.
  Future<AuthLoginResponse?> linkAccountWithGoogleAccount(String token) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithGoogleAccount.socket,
          {'token': token},
        );

        return socketResp.mapToResponse<AuthLoginResponse>(
          (data) => AuthLoginResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('linkAccountWithGoogle with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.linkAccountWithGoogleAccount.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  /// [Hybrid]
  Future<UserCollection?> unlinkAccountWithGoogleAccount() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.unlinkAccountWithGoogleAccount.socket,
          {},
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('unlinkAccountWithGoogle with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(BackendPath.unlinkAccountWithGoogleAccount.http);

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<AuthLoginResponse?> linkAccountWithAppleId(String token) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithAppleId.socket,
          {'token': token},
        );

        return socketResp.mapToResponse<AuthLoginResponse>(
          (data) => AuthLoginResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('linkAccountWithAppleId with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.linkAccountWithAppleId.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  Future<UserCollection?> unlinkAccountWithAppleId() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithAppleId.socket,
          {},
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('unlinkAccountWithAppleId with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.unlinkAccountWithAppleId.http,
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<AuthLoginResponse?> linkAccountWithFacebookAccount(String token) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithFacebook.socket,
          {'token': token},
        );

        return socketResp.mapToResponse<AuthLoginResponse>(
          (data) => AuthLoginResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('linkAccountWithFacebook with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.linkAccountWithFacebook.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  Future<UserCollection?> unlinkAccountWithFacebook() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithFacebook.socket,
          {},
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('unlinkAccountWithAppleId with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.unlinkAccountWithFacebook.http,
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<SocialLinkResponse?> settingAccountLinkAccountWithGoogle(UpdateLinkingAccountWithSocialRequest params) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.settingAccountLinkAccountWithGoogle.socket,
          params.toMap(),
        );

        return socketResp.mapToResponse<SocialLinkResponse>(
          (data) => SocialLinkResponse.fromJson(data),
        );
      } catch (e, stackTrace) {
        _log.w('settingAccountLinkAccountWithGoogle with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.settingAccountLinkAccountWithGoogle.http,
      data: params.toMap(),
    );

    return httpResp.mapToResponse<SocialLinkResponse>(
      (data) => SocialLinkResponse.fromJson(data),
    );
  }

  Future<SocialLinkResponse?> settingAccountUnlinkAccountWithGoogle(String actionToken) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.settingAccountUnlinkAccountWithGoogle.socket,
          {'actionToken': actionToken},
        );

        return socketResp.mapToResponse<SocialLinkResponse>(
          (data) => SocialLinkResponse.fromJson(data),
        );
      } catch (e, stackTrace) {
        _log.w('settingAccountUnlinkAccountWithGoogle with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.settingAccountUnlinkAccountWithGoogle.http,
      data: {'actionToken': actionToken},
    );

    return httpResp.mapToResponse<SocialLinkResponse>(
      (data) => SocialLinkResponse.fromJson(data),
    );
  }

  Future<SocialLinkResponse?> settingAccountLinkAccountWithApple(UpdateLinkingAccountWithSocialRequest params) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.settingAccountLinkAccountWithApple.socket,
          params.toMap(),
        );

        return socketResp.mapToResponse<SocialLinkResponse>(
          (data) => SocialLinkResponse.fromJson(data),
        );
      } catch (e, stackTrace) {
        _log.w('settingAccountLinkAccountWithApple with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.settingAccountLinkAccountWithApple.http,
      data: params.toMap(),
    );

    return httpResp.mapToResponse<SocialLinkResponse>(
      (data) => SocialLinkResponse.fromJson(data),
    );
  }

  Future<SocialLinkResponse?> settingAccountUnlinkAccountWithApple(String actionToken) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.settingAccountUnlinkAccountWithApple.socket,
          {'actionToken': actionToken},
        );

        return socketResp.mapToResponse<SocialLinkResponse>(
          (data) => SocialLinkResponse.fromJson(data),
        );
      } catch (e, stackTrace) {
        _log.w('settingAccountUnlinkAccountWithApple with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.settingAccountUnlinkAccountWithApple.http,
      data: {'actionToken': actionToken},
    );

    return httpResp.mapToResponse<SocialLinkResponse>(
      (data) => SocialLinkResponse.fromJson(data),
    );
  }

  Future<SocialLinkResponse?> settingAccountLinkAccountWithFacebook(
    UpdateLinkingAccountWithSocialRequest params,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.settingAccountLinkAccountWithFacebook.socket,
          params.toMap(),
        );

        return socketResp.mapToResponse<SocialLinkResponse>(
          (data) => SocialLinkResponse.fromJson(data),
        );
      } catch (e, stackTrace) {
        _log.w('settingAccountLinkAccountWithFacebook with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.settingAccountLinkAccountWithFacebook.http,
      data: params.toMap(),
    );

    return httpResp.mapToResponse<SocialLinkResponse>(
      (data) => SocialLinkResponse.fromJson(data),
    );
  }

  Future<SocialLinkResponse?> settingAccountUnlinkAccountWithFacebook(String actionToken) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.settingAccountUnlinkAccountWithFacebook.socket,
          {'actionToken': actionToken},
        );

        return socketResp.mapToResponse<SocialLinkResponse>(
          (data) => SocialLinkResponse.fromJson(data),
        );
      } catch (e, stackTrace) {
        _log.w('settingAccountUnlinkAccountWithFacebook with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.settingAccountUnlinkAccountWithFacebook.http,
      data: {'actionToken': actionToken},
    );

    return httpResp.mapToResponse<SocialLinkResponse>(
      (data) => SocialLinkResponse.fromJson(data),
    );
  }
}
