import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/datasources//api/rawg_api.dart' as api;
import 'package:game_app/domain/models/achievement_model.dart';
import 'package:game_app/domain/models/game_detail_model.dart';
import 'package:game_app/domain/models/screenshots_model.dart';
import 'package:game_app/domain/models/trailers_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/view/bland_picture_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';
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

  final SizeConfig _sizeConfig = SizeConfig();

  @override
  void initState() {
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
              TitleText(text: "${widget.name}", maxLines: 1,),
              NormalText(text: "Released: ${widget.releaseDate}!",),
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
          YMargin(10,),
          Hero(tag: widget.name,child: BlandPictureView(widget.backgroundImage)),
          YMargin(20,),
          TitleText(text: "Description", fontSize: 20,),
          _buildGameDetails(),
          YMargin(20,),
          TitleText(text: "Achievements", fontSize: 20,),
          _buildGameAchievements(),
          YMargin(20,),
          TitleText(text: "Screenshots", fontSize: 20,),
          _buildGameScreenshots(),
          YMargin(50,),
          //TODO: Might add trailer some.
//          Text("Trailers", style: Theme.of(context).textTheme.headline,),
//          _buildGameTrailer(),
//          SizedBox(height: 20,),

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
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var model = (snapshot.data as GameDetailModel);
            return Container(
              width: SizeConfig.screenWidthDp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  YMargin( 5,),
                  NormalText(text: "${model.description
                      .replaceAll("<p>", "")
                      .replaceAll("</p>", "")
                      .replaceAll("<br />",  "\n")}"),
                  YMargin(2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          if(model.website != null){
                            //Navigate to website
                          }
                        },
                        child: Icon(
                          LineAwesomeIcons.internet_explorer, size: 30,
                        ),
                      ),
                      YMargin(10),
                      GestureDetector(
                        onTap: (){
                          if(model.redditUrl != null){
                            //Navigate to website
                          }
                        },
                        child: Icon(
                            LineAwesomeIcons.reddit, size: 30
                        ),
                      )
                    ],
                  ),
                  YMargin(10,),
                  BlandPictureView(model.backgroundImageAdditional,),
                ],
              )
            );
          }else if(snapshot.hasError){
            return Container(
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameDetailFuture = _getGameDetails();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
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
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var model = (snapshot.data as AchievementModel);
            return Container(
                width: SizeConfig.screenWidthDp,
                child: model.name == "null" && model.description == "null" ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    NormalText(text: "${model.name}", ),
                    NormalText(text: "${model.description}", ),
                  ],
                ):NormalText(text: "No achievements to speak of.. For now", ),
            );
          }else if(snapshot.hasError){
            return Container(
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameAchievementsFuture = _getGameAchievements();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
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
              height: _sizeConfig.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var model = (snapshot.data as ScreenshotsModel);
            return Container(
              height: _sizeConfig.sh(270),
              width: SizeConfig.screenWidthDp,
              child: PageView.builder(
                  itemCount: model.results.length,
                  itemBuilder: (context, position){
                    return Container(margin: EdgeInsets.only(right: 5,),child: BlandPictureView(model.results[position].image));
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameScreenshotFututre = _getGameScreenshots();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
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
