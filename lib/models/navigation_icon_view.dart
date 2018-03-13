import 'package:augmentalflutter/constants.dart';
import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
            _animation = new CurvedAnimation(
              parent: controller,
              curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
            );
          }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),


        //TODO: PERSONALIZE VIEW IN HERE.
        ////
        child: new IconTheme(
          data: new IconThemeData(
            color: Constants.augmentalColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
       ///

      ),
    );
  }
}