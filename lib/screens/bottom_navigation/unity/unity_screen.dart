// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
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
      final String result = await methodChannel.invokeMethod('openUnity');
      status = result;
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
    return new Center(
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(_status, key: const Key('Status key')),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                child: const Text('Open Unity'),
                onPressed: _openUnity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
