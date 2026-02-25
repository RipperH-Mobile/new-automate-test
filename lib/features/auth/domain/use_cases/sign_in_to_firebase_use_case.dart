import 'package:firebase_auth/firebase_auth.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/features/auth/domain/params/sign_in_to_firebase_params.dart';
import 'package:uchat/use_cases/use_case.dart';

class SignInToFirebaseUseCase extends SimpleUseCase<User, SignInToFirebaseParams> {
  @override
  Future<User> call(SignInToFirebaseParams params) async {
    final firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      if (firebaseAuth.currentUser?.uid == params.signInUserId) {
        // If user is already login don't do anything.
        return firebaseAuth.currentUser!;
      } else {
        await firebaseAuth.signOut();
      }
    }
    final result = await firebaseAuth.signInWithCustomToken(params.token);
    if (result.user == null) throw NullResponseException();
    return result.user!;
  }
}
