import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthService {
  Future<bool> isAvailable() async {
    return await SignInWithApple.isAvailable();
  }

  Future<AuthorizationCredentialAppleID> signIn() async {
    return await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
    );
  }

  Future<String?> getIdToken() async {
    final credential = await signIn();
    return credential.identityToken;
  }
}
