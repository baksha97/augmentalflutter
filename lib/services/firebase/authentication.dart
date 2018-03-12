import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';


class UserData {
  String displayName;
  String email;
  String uid;
  String password;

  UserData({this.displayName, this.email, this.uid, this.password});
}

class UserAuth {
  ///String statusMsg="Account Created Successfully";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final googleSignIn = new GoogleSignIn();                          // new
  // /
  //To create new User
  Future<String> createUser(UserData userData) async{
    await firebaseAuth
        .createUserWithEmailAndPassword(
        email: userData.email, password: userData.password);
    return 'Created new account';
  }

  //To sign user in with email and password
  Future<String> signIn(String email, String password) async{
    await firebaseAuth
        .signInWithEmailAndPassword(
        email: email, password: password);
    return 'Signed In';
  }

//  static Future<Null> signInGoogle() async {
//    try {
//      await googleSignIn.signIn();
//    } catch (error) {
//      print(error);
//    }
//  }

  //To verify new User
  Future<String> verifyUser (UserData userData) async{
    await firebaseAuth
        .signInWithEmailAndPassword(email: userData.email, password: userData.password);
    return "Login Successfull";
  }

  //ensure logged in
  static Future<Null> ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null)
      user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
    }
  }
}

