// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:augmentalflutter/assets.dart';
import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/models/navigation_icon_view.dart';
import 'package:augmentalflutter/screens/bottom_navigation/chat/chat_selection.dart';
import 'package:augmentalflutter/services/firebase/authentication.dart';
import 'package:flutter/material.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/friend_details_page.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/friend.dart';


class BottomNavigation extends StatefulWidget {
  static const String route = '/screens/bottom_navigation';

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {

  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();

    Color barColor = Constants.augmentalColor;

    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.home),
        title: 'Home',
        view: new Center(
          child:
          new Image.asset(
            'assets/test.gif',
            width: 400.0,
            height: 400.0,
          ),
        ),
        color: barColor,
        vsync: this,
      ),

      new NavigationIconView(
        icon: const Icon(Icons.message),
        title: 'Chat',
        view:  new ChatSelection(),
        color: barColor,
        vsync: this,
      ),

      new NavigationIconView(
        icon: new Icon(Assets.augmentalIconData),// Constants.icon,//const Icon(Icons.remove_red_eye),
        title: 'Unity',
        color: barColor,
        vsync: this,
      ),

      new NavigationIconView(
        icon: const Icon(Icons.person_outline),
        title: 'Profile',
        view: new FriendDetailsPage(new Friend(avatar: UserAuth.googleSignIn.currentUser.photoUrl, name: UserAuth.displayName, email: UserAuth.googleSignIn.currentUser.email, location: "NY"), avatarTag: 'me'),
        color: barColor,
        vsync: this,
      ),
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }



  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      fixedColor: Constants.augmentalColor,
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          //TODO: REMOVE AFTER LOGOUT METHOD CREATED
          if(_currentIndex == _navigationViews.length-2){
            UserAuth.signOut();
          }
        });
      },
    );

    return new Scaffold(
      appBar: null,
      body: new Center(
          child: _buildTransitionsStack()
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}