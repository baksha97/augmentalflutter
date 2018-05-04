import 'dart:async';
import 'dart:io' as io;
import 'package:augmentalflutter/models/feed_card.dart';
import 'package:augmentalflutter/services/firebase/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/models/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'dart:math';

class HomeScreen extends StatefulWidget {
  static const String route = '/screens/bottom_navigation/home_screen';

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double height = 366.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        backgroundColor: Constants.augmentalColor,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView(
                children: <Widget>[
                  new ListTile(
                    //  final String username, photoURL, scoredPoints, totalPoints, percentage, time;

                    title: new FeedCard.demoWithData(
                      username: 'Maynard SandToast',
                      photoURL:
                          'https://www.codeadvantage.org/img/bio/1I0EEVORX9.jpg',
                      scoredPoints: '100',
                      totalPoints: '500',
                      time: 'Time',
                      achievements: ["ur amazon"],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({@required final chatReference, @required final chatName})
      : _messRef = Firestore.instance
            .collection('chats/$chatReference/messages'), //chatReference,
        _chatRef = Firestore.instance.document('chats/$chatReference'),
        _chatName = chatName; //chatReference;

  final _chatName;
  final _messRef;
  final _chatRef;
  // static const String route = '/screens/bottom_navigation/chat_screen';
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  bool _isTyping = false;
  final analytics = new FirebaseAnalytics();
  var formatter = new DateFormat.yMd().add_jm();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget._chatName),
        backgroundColor: Constants.augmentalColor,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new StreamBuilder(
                stream: widget._messRef.snapshots,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new CircularProgressIndicator();
                  return new ListView(
                    reverse: true,
                    //shrinkWrap: true,
                    children: snapshot.data.documents
                        .map((document) {
                          return new ListTile(
                            title: new Bubble(snapshot: document),
                            onTap: () {},
                          );
                        })
                        .toList()
                        .reversed
                        .toList(),
                  );
                },
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTestComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        child: new Row(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.photo_camera),
                  onPressed: () async {
                    //fl await UserAuth.ensureLoggedIn(_context);
                    io.File image = await picker.ImagePicker.pickImage();
                    int r = new Random().nextInt(100000);
                    StorageReference ref =
                        FirebaseStorage.instance.ref().child("image_$r.jpg");
                    StorageUploadTask upload = ref.put(image);
                    Uri downloadUrl = (await upload.future).downloadUrl;
                    _sendMessage(imageUrl: downloadUrl.toString());
                  }),
            ),
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isTyping = true;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Enter a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: _isTyping
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _isTyping = false;
    });
    await UserAuth.ensureLoggedIn(_context);
    _sendMessage(text: text);
  }

  void _sendMessage({String text, String imageUrl}) {
    widget._messRef.document().setData({
      'text': text,
      'imageUrl': imageUrl,
      'senderName': UserAuth.googleSignIn.currentUser.displayName,
      'senderEmail': UserAuth.googleSignIn.currentUser.email,
      'senderPhotoUrl': UserAuth.googleSignIn.currentUser.photoUrl,
      'timestamp': formatter.format(new DateTime.now()),
    });

    widget._chatRef.updateData({
      'senderName': UserAuth.googleSignIn.currentUser.displayName,
      'last-message': text ?? 'Image',
    });
    analytics.logEvent(name: 'send_message');
  }
}
