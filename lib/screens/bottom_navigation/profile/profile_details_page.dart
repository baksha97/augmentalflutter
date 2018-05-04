import 'package:augmentalflutter/assets.dart';
import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/routes.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/footer/profile_detail_footer.dart';
import 'package:augmentalflutter/models/augmental_user.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/profile_detail_body.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/header/profile_detail_header.dart';
import 'package:augmentalflutter/services/firebase/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

//TODO: instead of pushing a profile from userauth, it would be better to initialize a stream here to refresh the given view every time
// theres a change such as changing the currentAuth status.

class ProfileDetailsPage extends StatefulWidget {
  ProfileDetailsPage(
    this.friend, {
    @required this.avatarTag,
  });

  final AugmentalUser friend;
  final Object avatarTag;

  @override
  _ProfileDetailsPageState createState() => new _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomCenter,//.bottomLeft,
        colors: [
          //const Color(0xFF413070),
          Constants.augmentalColor,
          Colors.black,
          //const Color(0xFF2B264A),
        ],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.friend.name),
        backgroundColor: Constants.augmentalColor,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings_power),
            tooltip: 'Sign Out',
            onPressed: (){
              UserAuth.signOut(context);
            },
          ),
        ],
      ),
      body: new SingleChildScrollView(
        physics: new ClampingScrollPhysics(),
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new ProfileDetailHeader(
                widget.friend,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new ProfileDetailBody(widget.friend),
              ),
              new ProfileShowcase(widget.friend),
            ],
          ),
        ),
      ),
    );
  }
}
