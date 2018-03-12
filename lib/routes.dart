import 'package:augmentalflutter/screens/login/login_screen.dart';
import 'package:flutter/material.dart';


//Mark: Global Variables
final Router appRouter = new Router._private();
final routes = {
  '/' :          (BuildContext context) => new LoginScreen(), //default route
  LoginScreen.route:         (BuildContext context) => new LoginScreen(),
//  '/bottom_navigation':         (BuildContext context) => new BottomNavigation(),
//  '/bottom_navigation/profile/home':         (BuildContext context) => new HomeScreen(),
//  '/screens/bottom_navigation/main_screen/delivery_screen':         (BuildContext context) => new DeliveryScreen(),
};

//Singleton
class Router{
  Router._private();

  void push(BuildContext cxt, String path){
    Navigator.of(cxt).pushNamed(path);
  }

  void pushReplacementTo(BuildContext cxt, String path){
    Navigator.of(cxt).pushReplacementNamed(path);
  }

}


