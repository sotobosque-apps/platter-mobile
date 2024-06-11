import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthNotifier extends ChangeNotifier {
  FirebaseAuthNotifier() {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     // print('User is currently signed out!');
    //     isValid(false);
    //   } else {
    //     // print('User is signed in!');
    //     isValid(true);
    //   }
    // });
  }
  Future<int> emailOTPAuthentication(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await credential.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      // print(e);
    }

    return -1;
  }

  Future<bool> isEmailAuthentic() async {
    return false;
  }

  Future<bool> newSession() async {
    return false;
  }

  Future<bool> closeSession() async {
    return false;
  }

  bool isValid(bool isValid) {
    return false;
  }
}
