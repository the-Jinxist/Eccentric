import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/models/GamesModel.dart';
import 'package:game_app/pages/GameDetailsPage.dart';
import 'package:game_app/utils/Utils.dart';
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/view/GameView.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController controller;
  String query = "";
  LoadingStates state;
  Future searchFuture;

  @override
  void initState() {
    super.initState();

    controller = new TextEditingController(text: "");
    state = LoadingStates.IDLE;
    searchFuture = getGames(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Search Games", style: Theme.of(context).textTheme.title,),
                Row(
                  children: <Widget>[
                    Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.orange)
                        ),
                        width: 400,
                        child: TextField(
                          controller: controller,
                          onSubmitted: (string){
                            if(string.isNotEmpty){
                              setState(() {
                                query = string.toLowerCase().trim();
                                state = LoadingStates.LOADING;
                              });
                            }
                          },
                          maxLines: 1,
                          textInputAction: TextInputAction.search,
                          style: Theme.of(context).textTheme.subtitle,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),
                            errorBorder: null,
                            focusedBorder: null,
                            disabledBorder: null,
                            enabledBorder: null,
                            border: null,

                          ),
                        )
                    ),
                    IconButton(
                      onPressed: (){
                        //Search Functionality
                        var string = controller.text;
                        if(string.isNotEmpty){
                          setState(() {
                            query = string.toLowerCase().trim();
                            state = LoadingStates.LOADING;
                          });

                        }
                      },
                      icon: Icon(LineAwesomeIcons.search, color: Colors.orange,),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ), preferredSize: Size.fromHeight(120)),
      body: loadWidgets(state),
    );
  }

  Widget loadWidgets(LoadingStates state) {
    if(state == LoadingStates.IDLE){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(LineAwesomeIcons.search, size: 50, color: Colors.grey,),
              SizedBox(height: 5,),
              Text("Search a repository of 350, 000+ games!"),
            ],
          ),
        ),
      );
    }else if(state == LoadingStates.LOADING){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator(),
        )
      );
    }else{
      return FutureBuilder(
        future: searchFuture,
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
                  return InkWell(child: GameView(gameModeL.results[position]),
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
                          searchFuture = getGames(query);
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
  }

  Future<GamesModel> getGames(String query) async {

    var response  = await api.getGamesFromSearch(query);

    if (response.statusCode == 200){
      var responseBody = json.decode(response.body);
//      print("Game Model: ${gameModel.GamesModel.fromJson(responseBody).results[3].slug}");
      return GamesModel.fromJson(responseBody);
    }else{
      print("Publishers Error: ${response.statusCode}");
      return null;
    }
  }
}