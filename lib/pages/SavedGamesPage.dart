import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_app/models/DatabaseModel.dart';
import 'package:game_app/models/GamesModel.dart';
import 'package:game_app/pages/GameDetailsPage.dart';
import 'package:game_app/view/GameView.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/repo/AuthRepo.dart';
import 'package:game_app/repo/DatabaseRepo.dart';

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
                        SizedBox(height: 20,),
                        FutureBuilder(
                          future: AuthRepo.getCurrentUser(),
                          builder: (context, snapshot){
                            print("Profile from saved games: ${snapshot.data}");
                            if(snapshot.hasData){
                              var user = snapshot.data as FirebaseUser;
                              if(user != null){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Well, since you've signed in. You could get your saved games we last store \n If you has any", style:
                                    Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey), textAlign: TextAlign.center,),
                                    SizedBox(height: 5,),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {

                                        });
                                      },
                                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                                    ),
                                  ],
                                );
                              }else{
                                return SizedBox();
                              }

                            }else{
                              return SizedBox();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
            },);
        },
      ),
    );
  }

  Future syncFromDb(BuildContext context, String userID) async{

    Scaffold.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(label: "Dismiss", onPressed: (){

          }),
            elevation: 5,
            backgroundColor: Colors.orange,
            content: Text("Game un-saved!", style: Theme.of(context).textTheme.subtitle.copyWith(
                color: Colors.white
            ))
        )
    );

    var results = await DatabaseRepo.saveCloudGamesToDB(userID: userID);
    if(results != null){

      Scaffold.of(context).showSnackBar(
          SnackBar(
              elevation: 5,
              backgroundColor: Colors.orange,
              content: Text("Syncing", style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: Colors.white
              ))
          )
      );

      setState(() {
        savedFuture = databaseHelper.getResult();
      });

    }else{
      Scaffold.of(context).showSnackBar(
          SnackBar(
              elevation: 5,
              backgroundColor: Colors.orange,
              content: Text("Sorry, you have no games saved :(", style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: Colors.white
              ))
          )
      );
    }
  }

  Future loadSyncButton() async{
    var user =  await AuthRepo.getCurrentUser();
    if(user == null) return;
  }

}
