import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/models/AchievementModel.dart';
import 'package:game_app/models/GameDetailModel.dart';
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/models/ScreenshotsModel.dart';
import 'package:game_app/models/TrailersModel.dart';
import 'package:game_app/view/BlandPictureView.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';


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

  Future gameDetailFuture;
  Future gameScreenshotFututre;
  Future gameAchievementsFuture;
  Future gameTrailerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gameDetailFuture = _getGameDetails();
    gameAchievementsFuture = _getGameAchievements();
    gameScreenshotFututre = _getGameScreenshots();
    gameTrailerFuture = _getGameTrailers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${widget.name}", style: Theme.of(context).textTheme.title.copyWith(fontSize: 30), maxLines: 1, overflow: TextOverflow.ellipsis,),
              Text("Released: ${widget.releaseDate}!", style: Theme.of(context).textTheme.subtitle,),
              RatingBar(
                onRatingUpdate: (rating){},
                allowHalfRating: true,
                itemCount: widget.ratingsTop,
                itemSize: 20,
                ignoreGestures: true,
                initialRating: widget.rating,
                glow: true,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.orange,
                ),

              )
            ],
          ),
          SizedBox(height: 10,),
          Hero(tag: widget.name,child: BlandPictureView(widget.backgroundImage)),
          SizedBox(height: 20,),
          Text("Description", style: Theme.of(context).textTheme.headline,),
          _buildGameDetails(),
          SizedBox(height: 20,),
          Text("Achievements", style: Theme.of(context).textTheme.headline,),
          _buildGameAchievements(),
          SizedBox(height: 20,),
          Text("Screenshots", style: Theme.of(context).textTheme.headline,),
          _buildGameScreenshots(),
          SizedBox(height: 20,),
          Text("Trailers", style: Theme.of(context).textTheme.headline,),
          SizedBox(height: 5,),

        ],
      ),
    );
  }

  Widget _buildGameDetails(){
    return FutureBuilder(
        future: gameDetailFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var model = (snapshot.data as GameDetailModel);
            return Container(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5,),
                  Text("${model.description
                      .replaceAll("<p>", "")
                      .replaceAll("</p>", "")
                      .replaceAll("<br />",  "\n")}", style: Theme.of(context).textTheme.display1,),
                  SizedBox(height: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.internet_explorer, size: 30,
                      ),
                      SizedBox(width: 10),
                      Icon(
                          LineAwesomeIcons.reddit, size: 30
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  BlandPictureView(model.backgroundImageAdditional,),
                ],
              )
            );
          }else if(snapshot.hasError){
            return Container(
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameDetailFuture = _getGameDetails();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildGameAchievements(){
    return FutureBuilder(
        future: gameAchievementsFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var model = (snapshot.data as AchievementModel);
            return Container(
                width: double.maxFinite,
                child: model.name == "null" && model.description == "null" ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${model.name}", style: Theme.of(context).textTheme.display1,),
                    Text("${model.description}", style: Theme.of(context).textTheme.display1,),
                  ],
                ):Text("No achievements to speak of.. For now", style: Theme.of(context).textTheme.display1,),
            );
          }else if(snapshot.hasError){
            return Container(
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameAchievementsFuture = _getGameAchievements();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildGameScreenshots(){
    return FutureBuilder(
        future: gameScreenshotFututre,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var model = (snapshot.data as ScreenshotsModel);
            return Container(
              height: 250,
              width: double.maxFinite,
              child: PageView.builder(
                  itemCount: model.results.length,
                  itemBuilder: (context, position){
                    return Container(margin: EdgeInsets.only(right: 5,),child: BlandPictureView(model.results[position].image));
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameScreenshotFututre = _getGameScreenshots();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Future<GameDetailModel> _getGameDetails() async{
    var response = await api.getGameDetail(widget.id);
    if(response.statusCode == 200){
      var model = GameDetailModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<AchievementModel> _getGameAchievements() async{
    var response = await api.getGameScreenshots(widget.slug);
    if(response.statusCode == 200){
      var model = AchievementModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<ScreenshotsModel> _getGameScreenshots() async{
    var response = await api.getGameScreenshots(widget.slug);
    if(response.statusCode == 200){
      var model = ScreenshotsModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<TrailersModel> _getGameTrailers() async{
    var response = await api.getGameTrailer(widget.slug);
    if(response.statusCode == 200){
      var model = TrailersModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

}
