import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';

abstract class SocialAuthServerRepository {
  Future<AuthLoginEntity> signInWithGoogle(String token);

  Future<AuthLoginEntity> linkAccountWithGoogle(String token);

  Future<void> unlinkAccountWithGoogle();

  Future<AuthLoginEntity> signInWithApple(String token);

  Future<AuthLoginEntity> linkAccountWithApple(String token);

  Future<void> unlinkAccountWithApple();

  Future<AuthLoginEntity> signInWithFacebook(String token);

  Future<AuthLoginEntity> linkAccountWithFacebook(String token);

  Future<void> unlinkAccountWithFacebook();
}
