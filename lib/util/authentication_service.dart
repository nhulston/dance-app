import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taneo/util/database_service.dart';
import 'package:taneo/util/preferences.dart';

class AuthenticationService {
  /// Current user's email as a string with global access
  static String? email;

  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Logs out of Firebase Auth, resets preferences and email
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    email = null;
    log('[Auth logOut] Logged out of email');
    Preferences.resetPrefs();

    if (user != null) {
      await googleSignIn.signOut();
      log('[Auth logOut] Logged out of google account');
    }
  }

  /// Handles logging in with email, sets email variable, updates preferences
  /// Inits DB then sets preferences stored on the DB
  /// Returns true if login successful, false otherwise
  Future<bool> logInWithEmail({required String email, required String password}) async {
    try {
      log('[Auth logInWithEmail] Attempting to login with email $email');
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      log('[Auth logInWithEmail] Logged in with email successfully');

      User user = FirebaseAuth.instance.currentUser!;
      AuthenticationService.email = user.email;
      Preferences.setExperienceLevel(await DatabaseService.getSkillLevel());

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        log('[Auth logInWithEmail] ' + e.message!);
      }
      return false;
    }
  }

  /// Handles signing up with email
  /// Returns true if successful, false if not
  Future<bool> signUpWithEmail({required String email, required String password}) async {
    try {
      log('[Auth signUpWithEmail] Attempting to sign up with email $email');
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      log('[Auth signUpWithEmail] Signed up with email successfully');

      User user = FirebaseAuth.instance.currentUser!;
      AuthenticationService.email = user.email;

      log('[Auth signUpWithEmail] Sending email verification to $email');
      user.sendEmailVerification();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        log('[Auth signUpWithEmail] ' + e.message!);
      }
      return false;
    }
  }


  final googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? user;

  /// Handles Google signup and login
  /// Initializes database and sets prefs from the database
  /// null = failed to login, true = first login, false = regular login
  Future<bool?> googleLogin() async {
    log('[Auth googleLogin] Google button clicked. Attempting login');
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      log('[Auth googleLogin] Google log in failed. Maybe user cancelled login?');
      return null;
    }

    user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    bool newUser = authResult.additionalUserInfo!.isNewUser;
    log('[Auth googleLogin] Google log in successful');
    log('[Auth googleLogin] First time logging in w/ Google: $newUser');

    if (!newUser) {
      Preferences.setExperienceLevel(await DatabaseService.getSkillLevel());
    }

    return newUser;
  }

  /// Returns whether the device is connected to the internet
  static Future<bool> connected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}