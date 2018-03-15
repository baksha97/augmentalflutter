import 'package:augmentalflutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({@required DocumentSnapshot snapshot, @required String displayName}):
      message = snapshot.data['text'],
      time = '',//snapshot.data['text']
      senderName = snapshot.data['senderName'],
      isMe = true,// displayName == snapshot.data['senderName'],
      delivered = true
      ;
  //final googleSignIn = new GoogleSignIn();
  final String message, time, senderName;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.white : Colors.lightBlue.shade100;//Colors.greenAccent.shade100;
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isMe
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
    return new Column(
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
                    new Text(message),
                    isMe ? new Text(senderName, textScaleFactor: 0.8,):
                      new Text(''),

                  ],
                ),
              ),
              new Positioned(
                bottom: 0.0,
                right: 0.0,
                child: new Row(
                  children: <Widget>[
                    new Text(time,
                        style: new TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
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
        )
      ],
    );
  }
}
