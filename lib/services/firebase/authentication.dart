import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final _googleSignIn = new GoogleSignIn();
  static String displayName;
  static final analytics = new FirebaseAnalytics();

  //ensure logged in
  static Future<Null> ensureLoggedIn() async {
    GoogleSignInAccount user = _googleSignIn.currentUser;
    if (user == null) user = await _googleSignIn.signInSilently();
    if (user == null) await _googleSignIn.signIn();
    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await _googleSignIn.currentUser.authentication;
      await _auth.signInWithGoogle(
          idToken: credentials.idToken, accessToken: credentials.accessToken);
    }
    displayName = _googleSignIn.currentUser.displayName;
    analytics.logLogin();
  }

  static Future<Null> signOut() async {
    analytics.logEvent(name: 'logout');
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> isSignedIn() async {
    return await _auth.currentUser() == null;
  }
}
