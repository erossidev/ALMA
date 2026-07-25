import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserService _userService = UserService();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Login Web (Chrome, Edge...)
        final GoogleAuthProvider provider = GoogleAuthProvider();

        final credential = await _auth.signInWithPopup(provider);

        await _userService.createOrUpdateUser();

        return credential;
      } else {
        // Login Android
        final GoogleSignInAccount? account =
            await _googleSignIn.signIn();

        if (account == null) return null;

        final GoogleSignInAuthentication auth =
            await account.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );

        final result = await _auth.signInWithCredential(credential);

        await _userService.createOrUpdateUser();

        return result;
      }
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    if (!kIsWeb) {
      await _googleSignIn.signOut();
    }

    await _auth.signOut();
  }

  Future<String?> getIdToken() async {
    return _auth.currentUser?.getIdToken();
  }
}