// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:augmentalflutter/assets.dart';
import 'package:augmentalflutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnityChannel extends StatefulWidget {
  @override
  _UnityChannelState createState() => new _UnityChannelState();
}

class _UnityChannelState extends State<UnityChannel> {
  static const MethodChannel methodChannel =
      const MethodChannel('augmental.io/unity');

  String _status = 'Unity';

  Future<Null> _openUnity() async {
    String status;
    try {
      await methodChannel.invokeMethod('openUnity');
    } on PlatformException {
      status = 'We\'ve encountered an error opening Unity, sorry about that...';
    }
    setState(() {
      _status = status;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Unity Launcher'),
        backgroundColor: Constants.augmentalColor,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Icon(
              Assets.unityIconData,
              size: 300.0,
              color: Constants.augmentalColor,
            ),
            new Padding(
              padding: new EdgeInsets.only(left: 40.0, right: 40.0),
              child: new RaisedButton(
                onPressed: _openUnity,
                color: Colors.white,
                textColor: Colors.black,
                child: new Text(_status),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
