import 'package:dictionary_app_1110/services/authentication/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //  Future<AuthStatus> resetPassword({required String email}) async {
  //   await FirebaseAuth.instance
  //       .sendPasswordResetEmail(email: email)
  //       .then((value) => _status = AuthStatus.successful)
  //       .catchError(
  //           (e) => _status = AuthExceptionHandler.handleAuthException(e));
  //   return _status;
  // }

  Future<String?> registration(
      {required String email,
      required String password,
      required String passwordAgain}) async {
    if (password != passwordAgain) {
      return "Confirm your \"password again\" ";
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return "";
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e).dialogText;
      }
    }
  }

  Future<(User?, FirebaseAuthException?)> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential.user!, null);
    } on FirebaseAuthException catch (e) {
      return (null, e);
    }
  }

  Future<int> logout({required User? user}) async {
    if (user != null) {
      await FirebaseAuth.instance.signOut();
      return 1;
    } else {
      return 0;
    }
  }
}
