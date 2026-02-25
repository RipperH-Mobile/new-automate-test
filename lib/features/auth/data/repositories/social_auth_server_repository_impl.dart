import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/features/auth/data/data_source/remote/social_auth_api_service.dart';
import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_server_repository.dart';

class SocialAuthServerRepositoryImpl implements SocialAuthServerRepository {
  SocialAuthServerRepositoryImpl({
    required this.socialAuthApiService,
  });

  final SocialAuthApiService socialAuthApiService;

  @override
  Future<AuthLoginEntity> linkAccountWithApple(String token) async {
    final response = await socialAuthApiService.linkAccountWithAppleId(token);
    if (response == null) {
      throw NullResponseException();
    }
    return response.toEntity();
  }

  @override
  Future<AuthLoginEntity> linkAccountWithFacebook(String token) async {
    final response = await socialAuthApiService.linkAccountWithFacebookAccount(token);
    if (response == null) {
      throw NullResponseException();
    }
    return response.toEntity();
  }

  @override
  Future<AuthLoginEntity> linkAccountWithGoogle(String token) async {
    final response = await socialAuthApiService.linkAccountWithGoogleAccount(token);
    if (response == null) {
      throw NullResponseException();
    }
    return response.toEntity();
  }

  @override
  Future<AuthLoginEntity> signInWithApple(String token) async {
    final response = await socialAuthApiService.signInWithApple(token);
    if (response == null) {
      throw NullResponseException();
    }
    return response.toEntity();
  }

  @override
  Future<AuthLoginEntity> signInWithFacebook(String token) async {
    final response = await socialAuthApiService.signInWithFacebook(token);
    if (response == null) {
      throw NullResponseException();
    }
    return response.toEntity();
  }

  @override
  Future<AuthLoginEntity> signInWithGoogle(String token) async {
    final response = await socialAuthApiService.signInWithGoogle(token);
    if (response == null) {
      throw NullResponseException();
    }
    return response.toEntity();
  }

  @override
  Future<void> unlinkAccountWithApple() async {
    await socialAuthApiService.unlinkAccountWithAppleId();
  }

  @override
  Future<void> unlinkAccountWithFacebook() async {
    await socialAuthApiService.unlinkAccountWithFacebook();
  }

  @override
  Future<void> unlinkAccountWithGoogle() async {
    await socialAuthApiService.unlinkAccountWithGoogleAccount();
  }
}
