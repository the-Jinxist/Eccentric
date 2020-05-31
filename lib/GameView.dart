import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'models/GameModel.dart';

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
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FadeInImage.assetNetwork(placeholder: "assets/images/kratos.jpg", image: widget.result.backgroundImage, fit: BoxFit.cover, height: 400, width: double.maxFinite,),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                onPressed: (){

                },
                tooltip: "Save Game",
                icon: Icon(LineAwesomeIcons.heart, color: Colors.white,),
              ),

            ),

            Positioned(
              right: 20,
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
                  SizedBox(height: 10,),
                  Text("Released: ${widget.result.released}",
                    style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5,),
                  Text("Rated: ${widget.result.rating} out of 10",
                    style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: 300,
                    child: Text("MetaCritic Rating: ${widget.result.metacritic} out of 10. Play time: ${widget.result.playtime}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),

//                  SizedBox(
//                    width: 300,
//                    child: Text("The 6th installment in the God of War series. Won Game of the year",
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
//                      textAlign: TextAlign.start,
//                    ),
//                  ),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}
