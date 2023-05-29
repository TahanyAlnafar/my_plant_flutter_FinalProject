import 'package:firebase_auth/firebase_auth.dart';

import '../app_routers/app_routers.dart';
class AuthHelper {
  AuthHelper._singleObj();

  static AuthHelper authHelper = AuthHelper._singleObj();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> login(String userEmail, String userPassword) async {
    try {
      AppRouter.showLoaderDialog();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      AppRouter.hideLoadingDialog();
      return credential.user?.uid;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppRouter.showCustomDialog('No user found for that email.');
        AppRouter.hideLoadingDialog();
      } else if (e.code == 'wrong-password') {
        AppRouter.showCustomDialog('Wrong password provided for that user.');
        AppRouter.hideLoadingDialog();
      }
    }
  }

  Future<bool> signup(String userEmail, String userPassword) async {
      try {
        AppRouter.showLoaderDialog();
        final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AppRouter.showCustomDialog('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AppRouter.showCustomDialog(
              'The account already exists for that email.');
        } else {
          AppRouter.showCustomDialog(e.toString());
        }
        return false;
      } catch (e) {
        return false;
      }
    }

  signOut() async {
    AppRouter.showCustomDialog('signed out successfully.');
    return await firebaseAuth.signOut();
  }

  checkUser() {
    return firebaseAuth.currentUser;
  }


}
