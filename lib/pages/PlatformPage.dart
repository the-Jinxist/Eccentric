import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/models/GamesModel.dart' as gameModel;
import 'package:game_app/models/PlatformModel.dart';
import 'package:game_app/pages/GameDetailsPage.dart';
import 'package:game_app/view/GameView.dart';

class PlatformPage extends StatefulWidget {

  final Result result;

  PlatformPage(this.result);

  @override
  _PlatformPageState createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {

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
                Text("Games on the", style: Theme.of(context).textTheme.subtitle,),
                Text("${widget.result.name}", style: Theme.of(context).textTheme.title, ),

              ],
            ),
          ),
          preferredSize: Size.fromHeight(100)
      ),
        body: FutureBuilder(
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
              var gameModeL = snapshot.data as gameModel.GamesModel;

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
              print("Platform Page: ${snapshot.error}");
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
        )
    );
  }

  Future<gameModel.GamesModel> getGames() async {

    print("Platform slug: ${widget.result.slug}");
    //nintendo-64
    //android
    //playstation4
    var response  = await api.getGamesFromPlatform(widget.result.slug);

    if (response.statusCode == 200){
      var responseBody = json.decode(response.body);
      print("Platform Page: ${gameModel.GamesModel.fromJson(responseBody).results}");
      return gameModel.GamesModel.fromJson(responseBody);
    }else{
      print("Platform Page: ${response.statusCode}");
      return null;
    }
  }
}
