import 'package:augmentalflutter/screens/bottom_navigation/bottom_navigation.dart';
import 'package:augmentalflutter/screens/bottom_navigation/chat/chat_selection.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/friend.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/friend_details_page.dart';
import 'package:augmentalflutter/screens/login/login_screen.dart';
import 'package:flutter/material.dart';


//Mark: Global Variables
final Router appRouter = new Router._private();
final routes = {
  '/' :          (BuildContext context) => new LoginScreen(), //default route
  LoginScreen.route:         (BuildContext context) => new LoginScreen(),
  BottomNavigation.route:         (BuildContext context) => new BottomNavigation(),
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

  void pushChatScreen(BuildContext cxt, String chatReference, String chatName){
    MaterialPageRoute chat =  new MaterialPageRoute(
        builder: (cxt) => new ChatScreen(chatReference: chatReference, chatName: chatName,)
    );
    Navigator.push(cxt, chat);
  }

//  void pushFriendProfile(BuildContext cxt, Friend friend){
//    MaterialPageRoute chat =  new MaterialPageRoute(
//        builder: (cxt) => new FriendDetailsPage(friend)
//    );
//    Navigator.push(cxt, chat);
//  }

}


