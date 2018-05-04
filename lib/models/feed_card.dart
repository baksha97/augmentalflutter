import 'package:augmentalflutter/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  final List<String> achievements;
  //final GlobalKey<AnimatedCircularChartState> chartKey;

  final CircularStackEntry data;


FeedCard.demoWithData({this.username, this.photoURL,this.scoredPoints,this.totalPoints,this.time,this.achievements}):
   // int failure = totalPoints - earnedPoints;
      data = new CircularStackEntry(
              <CircularSegmentEntry>[
                new CircularSegmentEntry((double.parse(scoredPoints)), Constants.augmentalColor, rankKey: 'success'),
                new CircularSegmentEntry(9.0, Colors.red[300], rankKey: 'failure'),
              ],
              rankKey: 'Chart',
            ),
      percentage = "";//(double.parse(totalPoints) - double.parse(scoredPoints)).toString();


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
                  margin: const EdgeInsets.only(top: 10.0, left: 5.0),
                  child: new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Row(
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundImage: new CachedNetworkImageProvider(photoURL),
                          radius: 40.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(username),
                              new Text(time),
                            ],
                          ),
                        )
                      ],
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
                    child: new AnimatedCircularChart(
                    //  key: new GlobalKey<AnimatedCircularChartState>(),
                      size: const Size(300.0, 300.0),
                      initialChartData: <CircularStackEntry>[data],
                      chartType: CircularChartType.Pie,
                    ),
                  ),
                ),
              ],
            ),
            //new Row -> add icon -> # Achievements; set onTap() for text OR if not, put row inside of a container and set the onTap(){}
          ],
        ));
  }

}
