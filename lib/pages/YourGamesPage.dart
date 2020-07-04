import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/pages/GameDetailsPage.dart';
import 'package:game_app/view/GameView.dart';
import 'package:game_app/models/GamesModel.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/repo/PrefsRepo.dart' as repo;
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/pages/GenresPage.dart';

class YourGamesPage extends StatefulWidget {
  @override
  _YourGamesPageState createState() => _YourGamesPageState();
}

class _YourGamesPageState extends State<YourGamesPage> {

  Future future;

  @override
  void initState() {
    future = getGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Your Games", style: Theme.of(context).textTheme.title,),
                  Text("Games that match your interests!", style: Theme.of(context).textTheme.subtitle,),
                ],
              ),
              IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenresPage()));
                },
                icon: Icon(LineAwesomeIcons.gear,),
              )
            ],
          ),
        ), preferredSize: Size.fromHeight(100)),
        body: Builder(
          builder: (context){
            return FutureBuilder(
              future: future,
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
                  var gameModel = snapshot.data as GamesModel;

                  return ListView.builder(
                      itemCount: gameModel.results.length,
                      itemBuilder: (context, position){
                        var currentGame = gameModel.results[position];
                        return InkWell(child: GameView(
                            onSavedTap: (string) {
                              if (string == "Added") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        elevation: 5,
                                        backgroundColor: Colors.orange,
                                        content: Text("Game saved!", style: Theme.of(context).textTheme.subtitle.copyWith(
                                          color: Colors.white
                                        ))
                                    )
                                );
                              } else {
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
                            },
                            result: gameModel.results[position]),
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
                          },);
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
                                future = getGames();
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
          },
        )
      ),
    );
  }

  Future<GamesModel> getGames() async {

    var genreString = await repo.getGenreString();
    var response  = await api.getGames(genreString);

    if (response.statusCode == 200){
      var responseBody = json.decode(response.body);
//      print("Game Model: ${GamesModel.fromJson(responseBody).results[3].slug}");
      return GamesModel.fromJson(responseBody);
    }else{
      print("Game Model Error: ${response.statusCode}");
      return null;
    }
  }
}
