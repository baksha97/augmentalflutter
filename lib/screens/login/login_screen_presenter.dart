//import 'package:login_app/data/rest_ds.dart';
//import 'package:login_app/models/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(String user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  //RestDatasource api = new RestDatasource();
  LoginScreenPresenter(this._view);

  doLogin(String username, String password) {
    print('$username with password $password');
    print(_view.toString());
  }


}