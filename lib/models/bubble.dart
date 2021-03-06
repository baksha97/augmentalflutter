import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/services/firebase/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Bubble extends StatelessWidget {
  Bubble({@required DocumentSnapshot snapshot})
      : message = snapshot.data['text'],
        time = snapshot.data['timestamp'] ?? '', //snapshot.data['text']
        senderName = snapshot.data['senderName'],
        senderPhotoUrl = snapshot.data['senderPhotoUrl'],
        isCurrentUser = (UserAuth.email == snapshot.data['senderEmail']),
        imageUrl = snapshot.data['imageUrl'];

  final String message, time, senderName, senderPhotoUrl, imageUrl;
  final isCurrentUser;
  final icon = Icons.done_all;
  final bubbleImageInsets = const EdgeInsets.all(8.0);
  final bubbleImageHeightAndWidth = 300.0;

  Widget _otherUserBubble() {
    final bg = Colors.grey.shade100;
    final align = CrossAxisAlignment.start;
    final mainAxisAlignment = MainAxisAlignment.start;

    final radius = new BorderRadius.only(
      topRight: new Radius.circular(30.0),
      bottomLeft: new Radius.circular(10.0),
      bottomRight: new Radius.circular(30.0),
    );

    return new Row(
      crossAxisAlignment: align,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: new CircleAvatar(
            backgroundImage: new CachedNetworkImageProvider(senderPhotoUrl),
          ),
        ),
        new Expanded(
          child: new Column(
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
                      padding: new EdgeInsets.only(right: 3.0),
                      child: new Column(
                        crossAxisAlignment: align,
                        children: <Widget>[
                          new Container(
                            child: imageUrl != null
                                //TODO: Add Circle Progress to image inside of bubble while still using an ImageProvider.
                                ? new Container(
                                    height: bubbleImageHeightAndWidth,
                                    width: bubbleImageHeightAndWidth,
                                    margin: bubbleImageInsets,
                                    decoration: new BoxDecoration(
                                      borderRadius: radius,
                                      image: new DecorationImage(
                                        image: new CachedNetworkImageProvider(
                                          imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : new Text(
                                    message,
                                    softWrap: true,
                                  ),
                          ),
                          new Text(
                            senderName,
                            style: new TextStyle(
                              color: Colors.black45,
                              fontSize: 13.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Row(
                crossAxisAlignment: align,
                mainAxisAlignment: mainAxisAlignment,
                children: <Widget>[
                  new Text(
                    time,
                    style: new TextStyle(
                      color: Colors.black38,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _currentUserBubble() {
    final bg = Constants.augmentalColor;
    final textColor = Colors.white;
    final align = CrossAxisAlignment.end;
    final mainAxisAlignment = MainAxisAlignment.end;

    final radius = new BorderRadius.only(
      topLeft: new Radius.circular(30.0),
      topRight: new Radius.circular(30.0),
      bottomLeft: new Radius.circular(30.0),
    );

    return new Row(
      crossAxisAlignment: align,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        new Expanded(
          child: new Column(
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
                      color: Colors.black.withOpacity(.12),
                    )
                  ],
                  color: bg,
                  borderRadius: radius,
                ),
                child: new Stack(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(right: 3.0),
                      child: new Column(
                        crossAxisAlignment: align,
                        children: <Widget>[
                          new Container(
                            child: imageUrl != null
                                //TODO: Add Circle Progress to image inside of bubble while still using an ImageProvider.
                                ? new Container(
                                    height: bubbleImageHeightAndWidth,
                                    width: bubbleImageHeightAndWidth,
                                    margin: bubbleImageInsets,
                                    decoration: new BoxDecoration(
                                      borderRadius: radius,
                                      image: new DecorationImage(
                                        image: new CachedNetworkImageProvider(
                                          imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : new Text(
                                    message,
                                    softWrap: true,
                                    style: new TextStyle(color: textColor),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Row(
                crossAxisAlignment: align,
                mainAxisAlignment: mainAxisAlignment,
                children: <Widget>[
                  new Text(
                    time,
                    style: new TextStyle(
                      color: Colors.black38,
                      fontSize: 10.0,
                    ),
                  ),
                  new Icon(
                    icon,
                    size: 12.0,
                    color: Colors.black38,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCurrentUser) {
      return _currentUserBubble();
    } else {
      return _otherUserBubble();
    }
  }
}
