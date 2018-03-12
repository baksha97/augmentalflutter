import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/screens/login/login_screen_presenter.dart';
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

class LoginScreenState extends State<LoginScreen> implements LoginScreenContract{//, AuthStateListener {
  //BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    //var authStateProvider = new AuthStateProvider();
    //authStateProvider.subscribe(this);
  }

  void _submit() {
    UserAuth.ensureLoggedIn();
//    final form = formKey.currentState;
//    if (form.validate()) {
//      setState(() => _isLoading = true);
//      form.save();
//      //_presenter.doLogin(_username, _password);
//      //moved this here to perform route
//      //appRouter.pushReplacementTo(_ctx, '/');
//    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

//  @override
//  onAuthStateChanged(AuthState state) {
//
//    if(state == AuthState.LOGGED_IN)
//      Navigator.of(_ctx).pushReplacementNamed("/home");
//  }

  //make login form
  Widget getLoginForm(){
    //create form
    var logo = new Image.asset(
      'assets/augmental_logo.jpg',
      width: 300.0,
      height: 300.0,
    );
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Sign in with Google"),
      color: Constants.augmentalColor,
      textColor: Colors.white,
    );

    var form = new Column(
        children: <Widget>[logo, loginBtn]
    );
    return form;
  }

  @override
  Widget build(BuildContext context) {
    //set context
    //_ctx = context;

    //get form
    var loginForm = getLoginForm();
    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[loginForm],
          )//loginForm
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    // TODO: implement onLoginError
  }

  @override
  void onLoginSuccess(String user) {
    // TODO: implement onLoginSuccess
  }
}