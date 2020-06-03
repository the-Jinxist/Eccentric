import 'package:flutter/material.dart';
import 'package:game_app/utils/GameDetailDelegate.dart';

class GameDetailsPage extends StatefulWidget {

  final int id;
  final String name;
  final String slug;
  final String backgroundImage;
  final String releaseDate;
  final int metacriticRating;
  final int playTime;
  final int suggestionsCount;
  final int ratingsTop;
  final int ratingsCount;
  final double rating;

  GameDetailsPage({this.id, this.name, this.slug, this.backgroundImage,
  this.releaseDate, this.metacriticRating, this.playTime, this.suggestionsCount,
  this.ratingsTop, this.ratingsCount, this.rating});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled){
          return <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: GameDetailDelegate(
                  suggestionsCount: widget.suggestionsCount,
                  ratingsTop: widget.ratingsTop,
                  ratingsCount: widget.ratingsCount,
                  rating: widget.rating,
                  backgroundImage: widget.backgroundImage,
                  name: widget.name,
                  metacriticRating: widget.metacriticRating,
                  playTime: widget.playTime,
                  releaseDate: widget.releaseDate
              )
            ),
          ];
        },
        body: FutureBuilder(
          builder: null
        )
      )
    );
  }

}
