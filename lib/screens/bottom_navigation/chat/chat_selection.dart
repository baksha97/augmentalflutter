import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/models/bubble.dart';
import 'package:augmentalflutter/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

class ChatSelection extends StatefulWidget {
  static const String route = '/screens/bottom_navigation/chat_selection';

  @override
  ChatSelectionState createState() => new ChatSelectionState();
}

class ChatSelectionState extends State<ChatSelection> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Scene Discussion Chat"),
        backgroundColor: Constants.augmentalColor,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new StreamBuilder(
                stream: Firestore.instance.collection('chats').snapshots,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return new ListView(
                    children: snapshot.data.documents.map((document) {
                      return new ListTile(
                        title: new Text(document['name']),
                        onTap: () {
                          appRouter.pushChatScreen(
                            context,
                            document.documentID,
                            document['name'],
                          );
                          print('tapped');
                        },
                        subtitle: new Text(document['senderName'] +
                            ': ' +
                            document['last-message']),
                      );
                    }).toList(),
                  );
                },
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
  GoogleSignIn googleSignIn = new GoogleSignIn();
  final analytics = new FirebaseAnalytics();
  final auth = FirebaseAuth.instance;

  var formatter = new DateFormat.yMd().add_jm();

  @override
  Widget build(BuildContext context) {
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
                    reverse: false,
                    //shrinkWrap: true,
                    children: snapshot.data.documents.map((document) {
                      return new ListTile(
                        title: new Bubble(snapshot: document),
                        onTap: () {},
                      );
                    }).toList(),
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
                    await _ensureLoggedIn();
                    File image = await ImagePicker.pickImage();
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
    await _ensureLoggedIn();
    _sendMessage(text: text);
  }

  void _sendMessage({String text, String imageUrl}) {
    widget._messRef.document().setData({
      'text': text,
      'imageUrl': imageUrl,
      'senderName': googleSignIn.currentUser.displayName,
      'senderPhotoUrl': googleSignIn.currentUser.photoUrl,
      'timestamp': formatter.format(new DateTime.now()),
    });

    widget._chatRef.updateData({
      'senderName': googleSignIn.currentUser.displayName,
      'last-message': text ?? 'Image',
    });
    //analytics.logEvent(name: 'send_message');
  }

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
      //analytics.logLogin();
    }
    if (auth.currentUser == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(
          idToken: credentials.idToken, accessToken: credentials.accessToken);
    }
  }
}
