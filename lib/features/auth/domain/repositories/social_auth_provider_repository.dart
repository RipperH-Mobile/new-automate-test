import 'package:uchat/features/auth/data/models/requests/sign_in_with_facebook_param.dart';
import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';

abstract class SocialAuthProviderRepository {
  Future<LinkAccountAuthEntity> signInWithGoogle();

  Future<void> signOutGoogle();

  Future<void> unlinkWithGoogle();

  Future<LinkAccountAuthEntity> signInWithApple();

  Future<void> unlinkWithApple();

  Future<LinkAccountAuthEntity> signInWithFacebook(SignInWithFacebookParam? param);

  Future<void> signOutFacebook();

  Future<void> unlinkWithFacebook();
}
