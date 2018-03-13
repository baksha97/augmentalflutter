import 'dart:async';
import 'dart:ui' as ui;

import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/routes.dart';
import 'package:augmentalflutter/screens/bottom_navigation/bottom_navigation.dart';
import 'package:augmentalflutter/services/firebase/authentication.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  static const String route = '/login';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{//, AuthStateListener {
  BuildContext _ctx;

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();


  LoginScreenState() {
  }

  void _submit() async {
    await UserAuth.ensureLoggedIn();
    appRouter.pushReplacementTo(_ctx, BottomNavigation.route);
  }

//  void _showSnackBar(String text) {
//    scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(text)));
//  }

//  TODO: FIX - navigates to the next page if signed in, not sure where to put htis
//  void signInCheck(){
//   Future<bool> signedIn = UserAuth.isSignedIn();
//   if(signedIn != null) {
//     appRouter.pushReplacementTo(_ctx, BottomNavigation.route);
//   }
//  }


  @override
  Widget build(BuildContext context) {
    //set context
    _ctx = context;
    var boxContents = <Widget>[
      new Image.asset(
        'assets/augmental_name.png',
        width: 85.0,
        height: 29.0,
      ),
        new Image.asset(
          'assets/augmental_logo.jpg',
          width: 300.0,
          height: 300.0,
        ),
        new RaisedButton(
          onPressed: _submit,
          child: new Text("Sign in with Google"),
          color: Constants.augmentalColor,
          textColor: Colors.white,
        ),
      ];

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      backgroundColor: Constants.augmentalColor,
      body:
      new Center(
        child: new ClipRect(
          child: new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: new Container(
              width: 300.0,
              height: 400.0,
              decoration: new BoxDecoration(
                border: new Border.all(width: 1.0, color: Colors.white),
                borderRadius:
                const BorderRadius.all(const Radius.circular(8.0)),
                color: Colors.white,
              ),
              child: new Center(
                child: new Column(
                  children: boxContents
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}