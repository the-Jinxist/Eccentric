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
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: Container(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Search Games", style: Theme.of(context).textTheme.title,),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.grey.withOpacity(0.3)
                        ),
                        width: 300,
                        child: Center(
                          child: TextField(
                            controller: controller,
                            onSubmitted: (string){
                              if(string.isNotEmpty){
                                setState(() {
                                  query = string.toLowerCase().trim();
                                  searchFuture = getGames(query);
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
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,


                            ),
                          ),
                        )
                    ),
                    IconButton(
                      onPressed: (){
                        //Search Functionality
                        var string = controller.text;
                        print("Search Page: Controller Text: $string");
                        if(string.isNotEmpty){
                          setState(() {
                            query = string.toLowerCase().trim();
                            searchFuture = getGames(query);
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
      body: Builder(builder: (context) => loadWidgets(state)),
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
              Text("Search a repository of 350, 000+ games!", style:
              Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),),
            ],
          ),
        ),
      );
    }else if(state == LoadingStates.LOADING){
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
                  return InkWell(
                    child:
                      GameView(
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
                        },
                        result: gameModeL.results[position]
                      ),
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
                          searchFuture = getGames(query);
                        });
                      },
                      child: Text("Reload", style:
                      Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
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
      print("Search Page Model: ${GamesModel.fromJson(responseBody).results[3].slug}");
      return GamesModel.fromJson(responseBody);
    }else{
      print("Search Page Error: ${response.statusCode}");
      return null;
    }
  }
}
