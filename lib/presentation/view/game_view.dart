import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/domain/models/database_model.dart';
import 'package:game_app/domain/models/games_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class GameView extends StatefulWidget {

  final Result result;
  final Function onSavedTap;

  GameView({@required this.result, this.onSavedTap});

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {

  DatabaseHelper databaseHelper;
  Future savedFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    databaseHelper = DatabaseHelper();
    savedFuture = databaseHelper.getSingleQueryResult(widget.result.slug);
  }

  final SizeConfig _config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        width: SizeConfig.screenWidthDp,
        height: _config.sh(400),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(tag: widget.result.name,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder.png",
                  image: widget.result.backgroundImage,
                  fit: BoxFit.cover,
                  imageCacheHeight: _config.sh(450),
                  imageCacheWidth: _config.sw(800),
                  placeholderCacheHeight: _config.sh(400),
                  placeholderCacheWidth: _config.sw(400),
                  height: _config.sh(400),
                  width: SizeConfig.screenWidthDp,
                )
            ),
            Container(
              height: _config.sh(400),
              width: SizeConfig.screenWidthDp,
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
              right: 5,
              top: 10,
              child:
                FutureBuilder(
                  future: savedFuture,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      var listOfGames = snapshot.data as List<Result>;
                      print("Game view list: $listOfGames");
                      if(listOfGames.isEmpty){
                        return IconButton(
                          onPressed: (){
                            databaseHelper.insert(widget.result).then((int){
                              setState(() {
                                savedFuture = databaseHelper.getSingleQueryResult(widget.result.slug);
                              });
                            });

                            if(widget.onSavedTap != null) widget.onSavedTap("Added");

                          },
                          tooltip: "Save Game",
                          icon: Icon(LineAwesomeIcons.heart_o, color: Colors.white,),
                        );
                      }else{
                        return IconButton(
                          onPressed: (){
                            databaseHelper.delete(widget.result.id).then((int){
                              setState(() {
                                savedFuture = databaseHelper.getSingleQueryResult(widget.result.slug);
                              });

                            });

                            if(widget.onSavedTap != null) widget.onSavedTap("Removed");
                          },
                          tooltip: "Save Game",
                          icon: Icon(LineAwesomeIcons.heart, color: Colors.white,),
                        );
                      }

                    }else if(snapshot.hasError){
                      print("Game view error: ${snapshot.error}");
                      return IconButton(
                        onPressed: (){

                        },
                        tooltip: "Save Game",
                        icon: Icon(LineAwesomeIcons.heart_o, color: Colors.red,),
                      );

                    }else{
                      return IconButton(
                        onPressed: (){

                        },
                        tooltip: "Save Game",
                        icon: Icon(LineAwesomeIcons.heartbeat, color: Colors.orange,),
                      );
                    }
                  }
                )
            ),

            Positioned(
              right: 40,
              top: 10,
              child: IconButton(
                onPressed: (){

                },
                tooltip: "Share Game",
                icon: Icon(LineAwesomeIcons.share, color: Colors.white,),
              ),

            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: SizeConfig.screenWidthDp - 50,
                      child: NormalText(text: "${widget.result.name}",
                        textColor: Colors.white,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 3,),
                  NormalText(
                    text: "Released: ${widget.result.released}",
                    textColor: Colors.white,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    width: _config.sw(300),
                    child: NormalText(text: "MetaCritic Rating: ${widget.result.metacritic != null ? widget.result.metacritic : "None"}. Play time: ${widget.result.playtime}. "
                        "Suggestions: ${widget.result.suggestionsCount}",
                      maxLines: 3,
                      textColor: Colors.white,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 10),
                  NormalText(text: "Rating",
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: <Widget>[
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
                        itemCount: widget.result.ratingsTop,
                        tapOnlyMode: false,
                        direction: Axis.horizontal,
                        initialRating: widget.result.rating.roundToDouble(),
                      ),
                      SizedBox(width: 5),
                      NormalText(text: "Rates: ${widget.result.ratingsCount}",
                        textColor: Colors.white,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}
