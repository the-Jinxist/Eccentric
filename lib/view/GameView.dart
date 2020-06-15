import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/models/GamesModel.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class GameView extends StatefulWidget {

  final Result result;

  GameView(this.result);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
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
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(tag: widget.result.name,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder.png",
                  image: widget.result.backgroundImage,
                  fit: BoxFit.cover,
                  imageCacheHeight: 200,
                  imageCacheWidth: 400,
                  placeholderCacheHeight: 400,
                  placeholderCacheWidth: 400,
                  height: 400,
                  width: double.maxFinite,
                )
            ),
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
              right: 5,
              top: 10,
              child: IconButton(
                onPressed: (){

                },
                tooltip: "Save Game",
                icon: Icon(LineAwesomeIcons.heart_o, color: Colors.white,),
              ),

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
                  Text("${widget.result.name}",
                    style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 3,),
                  Text("Released: ${widget.result.released}",
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text("MetaCritic Rating: ${widget.result.metacritic != null ? widget.result.metacritic : "None"}. Play time: ${widget.result.playtime}. "
                        "Suggestions: ${widget.result.suggestionsCount}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Rating",
                    style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                        initialRating: widget.result.rating,
                      ),
                      SizedBox(width: 5),
                      Text("Rates: ${widget.result.ratingsCount}",
                        style: Theme.of(context).textTheme.display2.copyWith(color: Colors.white),
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
