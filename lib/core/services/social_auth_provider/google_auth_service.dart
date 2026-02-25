import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<GoogleSignInAccount?> signIn() async {
    return await _googleSignIn.signIn();
  }

  Future<void> signOut({bool unlink = false}) async {
    await _googleSignIn.signOut();

    if (unlink) {
      await this.unlink();
    }
  }

  Future<void> unlink() async {
    await _googleSignIn.currentUser?.clearAuthCache();
    await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
  }

  Future<void> signInSilently() async {
    if (_googleSignIn.currentUser == null) {
      await _googleSignIn.signInSilently();
    }
  }

  Future<bool> isSignedIn() async {
    return _googleSignIn.isSignedIn();
  }

  Future<GoogleSignInAuthentication?> getAuth() async {
    return (await _googleSignIn.currentUser?.authentication);
  }
}
