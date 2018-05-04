import 'package:augmentalflutter/assets.dart';
import 'package:augmentalflutter/models/augmental_user.dart';
import 'package:flutter/material.dart';

class ProfileDetailBody extends StatelessWidget {
  ProfileDetailBody(this.friend);

  final AugmentalUser friend;

  _createCircleBadge(IconData iconData, Color color) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new CircleAvatar(
        backgroundColor: color,
        child: new Icon(
          iconData,
          color: Colors.white,
          size: 24.0,
        ),
        radius: 24.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var locationInfo = new Row(
      children: [
        new Icon(
          Icons.place,
          color: Colors.white,
          size: 24.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            friend.location,
            style: textTheme.subhead.copyWith(color: Colors.white),
          ),
        ),
      ],
    );

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          friend.name,
          style: textTheme.headline.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: locationInfo,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            'Do you know the way?',
            style:
                textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Row(
            children: [
              //TODO: IMPLEMENT SCENE BADGES
              _createCircleBadge(Assets.unityIconData, Colors.black),
              _createCircleBadge(Icons.message, Colors.white12),
              _createCircleBadge(Icons.check_circle, Colors.white12),
            ],
          ),
        ),
      ],
    );
  }
}
