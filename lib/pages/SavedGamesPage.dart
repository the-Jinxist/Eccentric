import 'package:flutter/material.dart';
import 'package:game_app/models/GamesModel.dart';
import 'package:game_app/models/DatabaseModel.dart';
import 'package:game_app/pages/GameDetailsPage.dart';
import 'package:game_app/view/GameView.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class SavedGamesPage extends StatefulWidget {
  @override
  _SavedGamesPageState createState() => _SavedGamesPageState();
}

class _SavedGamesPageState extends State<SavedGamesPage> {
  List<Result> resultList;
  DatabaseHelper databaseHelper = DatabaseHelper();
  Future savedFuture;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    savedFuture = databaseHelper.getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Saved Games", style: Theme.of(context).textTheme.title, ),
            Text("Games you've taken a fancy to!", style: Theme.of(context).textTheme.subtitle,),
          ],
        ),
      ), preferredSize: Size.fromHeight(100)),
      body: Builder(
        builder: (context){
          return FutureBuilder(
            future: savedFuture,
            builder: (context, snapshot){
              if(snapshot.hasData){
                var gameList = snapshot.data as List<Result>;
                if(gameList.isNotEmpty){
                  return ListView.builder(
                      itemCount: gameList.length,
                      itemBuilder: (context, position){
                        var currentGame = gameList[position];
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameDetailsPage(
                              backgroundImage: currentGame.backgroundImage,
                              id: currentGame.id,
                              metacriticRating: currentGame.metacritic,
                              name: currentGame.name,
                              playTime: currentGame.playtime,
                              rating: currentGame.rating,
                              ratingsCount: currentGame.ratingsCount,
                              ratingsTop: currentGame.ratingsTop,
                              releaseDate: currentGame.released,
                              slug: currentGame.slug,
                              suggestionsCount: currentGame.suggestionsCount,
                            )));
                          },
                          child: GameView(
                            result: gameList[position],
                            onSavedTap: (string){
                              if(string == "Added"){
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        elevation: 5,
                                        backgroundColor: Colors.orange,
                                        content: Text("Game saved!", style: Theme.of(context).textTheme.subtitle.copyWith(
                                            color: Colors.white
                                        ))
                                    )
                                );
                              }else{
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        elevation: 5,
                                        backgroundColor: Colors.orange,
                                        content: Text("Game un-saved!", style: Theme.of(context).textTheme.subtitle.copyWith(
                                            color: Colors.white
                                        ))
                                    )
                                );
                              }

                              setState(() {
                                savedFuture = databaseHelper.getResult();
                              });
                            },
                          ),
                        );
                      }
                  );
                }else{
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(LineAwesomeIcons.heart, size: 50, color: Colors.grey,),
                          SizedBox(height: 5,),
                          Text("You've not found a game you like? How strange. How strange indeed", style:
                          Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  );
                }

              }else
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(LineAwesomeIcons.heart_o, size: 50, color: Colors.grey,),
                        SizedBox(height: 5,),
                        Text("You've not found a game you like? How strange. How strange indeed", style:
                        Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey), textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                );
            },);
        },
      ),
    );
  }
}
