import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {

  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final _googleSignIn = new GoogleSignIn();

  //ensure logged in
  static Future<Null> ensureLoggedIn() async {
    GoogleSignInAccount user = _googleSignIn.currentUser;
    if (user == null)
      user = await _googleSignIn.signInSilently();
    if (user == null)
      await _googleSignIn.signIn();
    if (await _auth.currentUser() == null){
      GoogleSignInAuthentication credentials = await _googleSignIn.currentUser.authentication;
      await _auth.signInWithGoogle(idToken: credentials.idToken, accessToken: credentials.accessToken);
    }
  }

  static Future<bool> isSignedIn() async{
    return await _auth.currentUser() == null;
  }

}


//Removed, currently only supporting Google Sign in
//class UserData {
//  String displayName;
//  String email;
//  String uid;
//  String password;
//
//  UserData({this.displayName, this.email, this.uid, this.password});
//}
//UserAuth class removals: TODO
////To create new User
//Future<String> createUser(UserData userData) async{
//  await firebaseAuth
//      .createUserWithEmailAndPassword(
//      email: userData.email, password: userData.password);
//  return 'Created new account';
//}
//  //To sign user in with email and password
//  Future<String> signIn(String email, String password) async{
//    await firebaseAuth
//        .signInWithEmailAndPassword(
//        email: email, password: password);
//    return 'Signed In';
//  }

//  //To verify new User
//  Future<String> verifyUser (UserData userData) async{
//    await firebaseAuth
//        .signInWithEmailAndPassword(email: userData.email, password: userData.password);
//    return "Login Successfull";
//  }

