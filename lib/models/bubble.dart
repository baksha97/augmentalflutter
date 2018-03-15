import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/services/firebase/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({@required DocumentSnapshot snapshot}):
      message = snapshot.data['text'],
      time = snapshot.data['timestamp'] ?? '',//snapshot.data['text']
      senderName = snapshot.data['senderName'],
      senderPhotoUrl = snapshot.data['senderPhotoUrl'],
      isNotMe = (UserAuth.displayName != snapshot.data['senderName']),
      delivered = true
      ;
  //final googleSignIn = new GoogleSignIn();
  final String message, time, senderName, senderPhotoUrl;
  final delivered, isNotMe;

  @override
  Widget build(BuildContext context) {
    final bg = isNotMe ? Colors.white : Colors.lightBlue.shade100;//Colors.greenAccent.shade100;
    final align = isNotMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final mainAxisAlignment = isNotMe ? MainAxisAlignment.start : MainAxisAlignment.end;

    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isNotMe
        ? new  BorderRadius.only(
      topRight: new Radius.circular(5.0),
      bottomLeft: new  Radius.circular(10.0),
      bottomRight: new  Radius.circular(5.0),
    )
        : new BorderRadius.only(
      topLeft: new Radius.circular(5.0),
      bottomLeft: new Radius.circular(5.0),
      bottomRight: new Radius.circular(10.0),
    );
    return new Row(
      crossAxisAlignment: align,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        isNotMe ? new Container(
                margin: const EdgeInsets.only(right: 5.0),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(senderPhotoUrl),
                  // radius: 10.0,
                ),
              ):
              new Container(),
        new Expanded(child:
        new Column(
        crossAxisAlignment: align,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),
            child: new Stack(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(right: 20.0),//48.0),
                  child: new Column(
                    crossAxisAlignment: align,
                    children: <Widget>[
                      //TODO: FIX WRAPING
                      new Text(message, softWrap: true,),
                      isNotMe ? new Text(
                        senderName,
                        style: new TextStyle(
                          color: Colors.black45,
                          fontSize: 13.0,
                        ),
                      ):
                        new Text(''),

                    ],
                  ),
                ),
                new Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: new Row(
                    children: <Widget>[
                      new SizedBox(width: 3.0),
                      new Icon(
                        icon,
                        size: 12.0,
                        color: Colors.black38,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
    new Text(time,
    style: new TextStyle(
    color: Colors.black38,
    fontSize: 10.0,
    )),
        ],
      ),
        ),
      ],
    );
  }
}
