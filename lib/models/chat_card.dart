import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//TODO: REMOVE NULL URL AFTER DEVELOPMENT

class ChatCard extends StatelessWidget {
  ChatCard({@required DocumentSnapshot snapshot})
      : name = snapshot.data['name'] ?? 'Stay tuned...',
        subtitle = snapshot.data['subtitle'] ?? 'Subtitle',
        description = snapshot.data['description'] ?? 'Description',
        imageUrl = snapshot.data['imageUrl'] ??
            'https://developers.giphy.com/static/img/api.c99e353f761d.gif',
        documentID = snapshot.documentID;

  final String name, subtitle, description, imageUrl, documentID;

  static const double height = 450.0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return new SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        height: height,
        child: new Card(
          color: Colors.grey.shade50,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // photo and title
              new SizedBox(
                height: 184.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                      child: new CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: new CircularProgressIndicator(),
                        errorWidget: new Icon(Icons.error),
                      ),
                    ),
                    new Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: new FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          name,
                          style: titleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // description and share/explore buttons
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: new DefaultTextStyle(
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // three line description
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            subtitle,
                            style: descriptionStyle.copyWith(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 147.0,
                          child: new SingleChildScrollView(
                            child: new Text(
                              description,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // share, explore buttons
              new ButtonTheme.bar(
                child: new ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                      child: const Text(
                        'CHAT',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Constants.augmentalColor,
                      onPressed: () {
                        appRouter.pushChatScreen(
                          context,
                          documentID,
                          name,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
