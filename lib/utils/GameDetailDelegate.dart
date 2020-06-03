import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class GameDetailDelegate implements SliverPersistentHeaderDelegate {

  final String backgroundImage;
  final String name;
  final String releaseDate;
  final int metacriticRating;
  final int playTime;
  final int suggestionsCount;
  final int ratingsTop;
  final int ratingsCount;
  final double rating;

  GameDetailDelegate({this.backgroundImage, this.name,
  this.releaseDate, this.metacriticRating, this.playTime, this.suggestionsCount,
  this.ratingsTop, this.ratingsCount, this.rating});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("Shrink Offset: $shrinkOffset");
    return Hero(
      tag: name,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: "assets/images/placeholder.png",
            image: backgroundImage,
            fit: BoxFit.cover, height: 400,
            width: double.maxFinite,),
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black
                    ],
                    stops: [
                      0.2,
                      1.0
                    ]
                )
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("$name",
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.white, fontSize: 30),
                    textAlign: TextAlign.start,
                  ),
                  RatingBar(
                    onRatingUpdate: (rating){

                    },
                    itemSize: 20.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: ratingsTop,
                    tapOnlyMode: false,
                    direction: Axis.horizontal,
                    initialRating: rating,
                  )
                ],
              ),
            ),

          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 120.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;



}