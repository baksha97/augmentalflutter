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

  String _status = 'Launch';

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
      body: new Flex(
        // physics: new ClampingScrollPhysics(),
        direction: Axis.vertical,
        children: <Widget>[
          new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Padding(
                  padding:
                      new EdgeInsets.only(top: 100.0),
                  child: new Icon(
                    Assets.unityIconData,
                    size: 250.0,
                    color: Constants.augmentalColor,
                  ),
                ),
                new Padding(
                  padding:
                      new EdgeInsets.only(top: 100.0, left: 40.0, right: 40.0),
                  child: new RaisedButton(
                    onPressed: _openUnity,
                    color: Constants.augmentalColor,
                    textColor: Colors.white,
                    child: new Text(_status),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//TODO: FIX THIS ERROR WHEN APPLICATION IS RESIGNING
/*
The following message was thrown during layout:
A RenderFlex overflowed by 127 pixels on the bottom.

The overflowing RenderFlex has an orientation of Axis.vertical.
The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and
black striped pattern. This is usually caused by the contents being too big for the RenderFlex.
Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the
RenderFlex to fit within the available space instead of being sized to their natural size.
This is considered an error condition because it indicates that there is content that cannot be
seen. If the content is legitimately bigger than the available space, consider clipping it with a
ClipRect widget before putting it in the flex, or using a scrollable container rather than a Flex,
like a ListView.
The specific RenderFlex in question is:
  RenderFlex#e11b7 relayoutBoundary=up8 OVERFLOWING
  creator: Column ← Container ← MediaQuery ← LayoutId-[<_ScaffoldSlot.body>] ←
  CustomMultiChildLayout ← DefaultTextStyle ← AnimatedDefaultTextStyle ←
  _InkFeatures-[GlobalKey#096e4 ink renderer] ← NotificationListener<LayoutChangedNotification> ←
  PhysicalModel ← AnimatedPhysicalModel ← Material ← ⋯
  parentData: offset=Offset(0.0, 76.0); id=_ScaffoldSlot.body (can use size)
  constraints: BoxConstraints(0.0<=w<=375.0, 0.0<=h<=159.0)
  size: Size(375.0, 159.0)
  direction: vertical
  mainAxisAlignment: center
  mainAxisSize: max
  crossAxisAlignment: stretch
  verticalDirection: down
 */
