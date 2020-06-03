import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${widget.name}", style: Theme.of(context).textTheme.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  Text("Released: ${widget.releaseDate}!", style: Theme.of(context).textTheme.subtitle,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
