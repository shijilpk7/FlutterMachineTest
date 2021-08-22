import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

//call very time when sign in button clicked
  Future googleLogin() async {
    try {
//call account selection popup
      final googleUser = await googleSignIn.signIn();
      //check account selected
      if (googleUser == null) return;
      //assign the selected account
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
