import 'package:augmentalflutter/constants.dart';
import 'package:augmentalflutter/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

//TODO: REMOVE NULL URL AFTER DEVELOPMENT

class FeedCard extends StatelessWidget {
  // FeedCard({@required DocumentSnapshot snapshot})
  //     : name = snapshot.data['name'] ?? 'Stay tuned...',
  //       subtitle = snapshot.data['subtitle'] ?? 'Subtitle',
  //       description = snapshot.data['description'] ?? 'Description',
  //       imageUrl = snapshot.data['imageUrl'] ??
  //           'https://developers.giphy.com/static/img/api.c99e353f761d.gif',
  //       documentID = snapshot.documentID;

  final String username, photoURL, scoredPoints, totalPoints, percentage, time;
  final GlobalKey<AnimatedCircularChartState> chartKey;
  List<CircularStackEntry> get data => <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
            new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
            new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
            new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
          ],
          rankKey: 'Quarterly Profits',
        ),
      ];

  const FeedCard(
      {Key key,
      this.username,
      this.photoURL,
      this.scoredPoints,
      this.totalPoints,
      this.percentage,
      this.time,
      this.chartKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return new Card(
        color: Colors.grey.shade50,
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 1.0),
                  child: new Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    child: new CircleAvatar(
                      backgroundImage: new CachedNetworkImageProvider(photoURL),
                      radius: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new DefaultTextStyle(
                      softWrap: true,
                      //overflow: TextOverflow.ellipsis,
                      style: descriptionStyle,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // three line description
                          new Container(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                            //height: 100.0,
                            child: new SingleChildScrollView(
                              child: new Text(
                                'Stats for: '+username,
                                softWrap: true,
                                style: descriptionStyle.copyWith(
                                  color: Colors.black,
                                  //decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          new AnimatedCircularChart(
                            key: new GlobalKey<AnimatedCircularChartState>(),
                            size: const Size(300.0, 300.0),
                            initialChartData: data,
                            chartType: CircularChartType.Pie,
                          )
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ],
        ));
  }

  //   return new SafeArea(
  //     top: false,
  //     bottom: false,
  //     child: new Container(
  //       padding: const EdgeInsets.all(8.0),
  //       height: height,
  //       child: new Card(
  //         color: Colors.grey.shade50,
  //         child: new Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             // photo and title
  //             // new SizedBox(
  //             //   height: 184.0,
  //             //   child: new Stack(
  //             //     children: <Widget>[
  //             //       new Positioned.fill(
  //             //         child: new CachedNetworkImage(
  //             //           imageUrl: imageUrl,
  //             //           placeholder: new CircularProgressIndicator(),
  //             //           errorWidget: new Icon(Icons.error),
  //             //         ),
  //             //       ),
  //             //       new Positioned(
  //             //         bottom: 16.0,
  //             //         left: 16.0,
  //             //         right: 16.0,
  //             //         child: new FittedBox(
  //             //           fit: BoxFit.scaleDown,
  //             //           alignment: Alignment.bottomLeft,
  //             //           child: new Text(
  //             //             name,
  //             //             style: titleStyle,
  //             //           ),
  //             //         ),
  //             //       ),
  //             //     ],
  //             //   ),
  //             // ),
  //             // description and share/explore buttons
  //             new Expanded(
  //               child: new Padding(
  //                 padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
  //                 child: new DefaultTextStyle(
  //                   softWrap: true,
  //                   //overflow: TextOverflow.ellipsis,
  //                   style: descriptionStyle,
  //                   child: new Column(
  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     children: <Widget>[
  //                       // three line description
  //                       new Padding(
  //                         padding: const EdgeInsets.only(bottom: 8.0),
  //                         child: new Text(
  //                           subtitle,
  //                           style: descriptionStyle.copyWith(
  //                             color: Colors.black,
  //                             decoration: TextDecoration.underline,
  //                           ),
  //                         ),
  //                       ),
  //                       new Container(
  //                         padding: const EdgeInsets.all(5.0),
  //                         decoration: new BoxDecoration(
  //                           color: Colors.white,
  //                         ),
  //                         height: 147.0,
  //                         child: new SingleChildScrollView(
  //                           child: new Text(
  //                             description,
  //                             softWrap: true,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // share, explore buttons
  //             new ButtonTheme.bar(
  //               child: new ButtonBar(
  //                 alignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   new FlatButton(
  //                     child: const Text(
  //                       'CHAT',
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     textColor: Constants.augmentalColor,
  //                     onPressed: () {},
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
