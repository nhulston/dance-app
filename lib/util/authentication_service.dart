import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  static String? email;

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> logOut() async {
    log('Logging out of email');
    await _firebaseAuth.signOut();
    email = null;

    if (user != null) {
      log('Logging out of google account');
      await googleSignIn.signOut();
    }
  }

  Future<String?> logIn({required String email, required String password}) async {
    try {
      log('Logging in with email');
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      AuthenticationService.email = _firebaseAuth.currentUser!.email;
      return 'Logged in successfully';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp({required String email, required String password}) async {
    try {
      log('Signing up with email');
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Signed up successfully';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  final googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? user;

  Future<bool> googleLogin() async {
    log('Logging in with Google');
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return false;

    user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  }
}