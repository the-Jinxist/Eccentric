import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/models/DatabaseModel.dart';
import 'package:game_app/models/GamesModel.dart';
import 'package:game_app/pages/GameDetailsPage.dart';
import 'package:game_app/repo/AuthRepo.dart';
import 'package:game_app/repo/DatabaseRepo.dart';
import 'package:game_app/view/GameView.dart';

class PopularPage extends StatefulWidget {
  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {

  Future loadGamesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadGamesFuture = getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Popular in 2020", style: Theme.of(context).textTheme.title, ),
                Text("Everybody's playing these game. Ugh!", style: Theme.of(context).textTheme.subtitle,),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100)
      ),
        body: Builder(
            builder: (context){
              return FutureBuilder(
                future: loadGamesFuture,
                builder: (context, snapshot){
                  if(snapshot.connectionState != ConnectionState.done){
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if(snapshot.hasData){
                    var gameModeL = snapshot.data as GamesModel;

                    return ListView.builder(
                        itemCount: gameModeL.results.length,
                        itemBuilder: (context, position){
                          var currentGame = gameModeL.results[position];
                          return InkWell(child: GameView(result: gameModeL.results[position],
                              onSavedTap: (string) {

                                if (string == "Added") {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.black,
                                          content: Text("Game added to favourite!")
                                      )
                                  );
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.black,
                                          content: Text("Game removed from favourite!")
                                      )
                                  );
                                }
                              },),
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

                          );
                        }
                    );
                  }else if(snapshot.hasError){
                    return Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Sorry an error occured",style: Theme.of(context).
                            textTheme.display1, textAlign: TextAlign.center,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  loadGamesFuture = getGames();
                                });
                              },
                              child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else{
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            }
        )
    );
  }

  Future<GamesModel> getGames() async {

    var response  = await api.getPopular();

    if (response.statusCode == 200){
      var responseBody = json.decode(response.body);
//      print("Platform Page: ${GamesModel.fromJson(responseBody).results[3].slug}");
      return GamesModel.fromJson(responseBody);
    }else{
      print("Popular Page: ${response.statusCode}");
      return null;
    }
  }
}
