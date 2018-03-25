import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final googleSignIn = new GoogleSignIn();
  static String displayName;
  static String email;
  static final analytics = new FirebaseAnalytics();

  //ensure logged in
  static Future<Null> ensureLoggedIn(BuildContext context) async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) await googleSignIn.signIn();
    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await _auth.signInWithGoogle(
          idToken: credentials.idToken, accessToken: credentials.accessToken);
    }

    displayName = googleSignIn.currentUser.displayName;
    email = googleSignIn.currentUser.email;
    await analytics.logLogin();
  }

  static Future<Null> signOut() async {
    analytics.logEvent(name: 'logout');
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> isSignedIn() async {
    return await _auth.currentUser() == null;
  }
}
