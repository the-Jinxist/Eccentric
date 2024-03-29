import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_app/domain/models/games_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/datasources/z_datasources.dart';

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
    super.initState();

    savedFuture = databaseHelper.getAllGamesService();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Builder(
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(60),
                  TitleText(text: "Saved Games",),
                  NormalText(text: "Games you've taken a fancy to!", ),
                  YMargin(15),
                  FutureBuilder(
                    future: savedFuture,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        var gameList = snapshot.data as List<Result>;
                        if(gameList.isNotEmpty){
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
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
                                                content: NormalText(text: "Game saved!", textColor: Colors.white)
                                            )
                                        );
                                      }else{
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                elevation: 5,
                                                backgroundColor: Colors.orange,
                                                content: NormalText(text: "Game in-saved!", textColor: Colors.white)
                                            )
                                        );
                                      }

                                      setState(() {
                                        savedFuture = databaseHelper.getAllGamesService();
                                      });
                                    },
                                  ),
                                );
                              }
                          );
                        }else{
                          return Container(
                            width: SizeConfig.screenWidthDp,
                            height: SizeConfig.screenHeightDp - 200,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(LineAwesomeIcons.heart, size: 50, color: Colors.grey,),
                                  YMargin(5,),
                                  NormalText(text: "You've not found a game you like? How strange. How strange indeed", textColor: Colors.grey, textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          );
                        }

                      }else
                        return Container(
                          width: SizeConfig.screenWidthDp,
                          height: SizeConfig.screenHeightDp - 200,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(LineAwesomeIcons.heart_o, size: 50, color: Colors.grey,),
                                YMargin(5,),
                                NormalText(text: "You've not found a game you like? How strange. How strange indeed", textColor: Colors.grey, textAlign: TextAlign.center,),
                                YMargin(20,),
                              ],
                            ),
                          ),
                        );
                    },),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future syncFromDb(BuildContext context, String userID) async{

    Scaffold.of(context).showSnackBar(
        SnackBar(
            elevation: 5,
            backgroundColor: Colors.orange,
            content: NormalText(text: "Game un-saved!", textColor: Colors.white)
        )
    );

    var results = await DatabaseRepo.saveCloudGamesToDB(userID: userID);
    if(results != null){

      Scaffold.of(context).showSnackBar(
          SnackBar(
              elevation: 5,
              backgroundColor: Colors.orange,
              content: NormalText(text: "Syncing", textColor: Colors.white)
          )
      );

      setState(() {
        savedFuture = databaseHelper.getAllGamesService();
      });

    }else{
      Scaffold.of(context).showSnackBar(
          SnackBar(
              elevation: 5,
              backgroundColor: Colors.orange,
              content: NormalText(text: "Sorry, you have no gaes saved", textColor: Colors.white)
          )
      );
    }
  }

  Future loadSyncButton() async{
    var user =  await AuthRepo.getCurrentUser();
    if(user == null) return;
  }

}
