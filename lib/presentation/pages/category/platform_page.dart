import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/datasources/api/rawg_api.dart' as api;
import 'package:game_app/domain/models/games_model.dart' as gameModel;
import 'package:game_app/domain/models/platform_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';

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
                NormalText(text: "Games on the"),
                TitleText(text: "${widget.result.name}",),

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
                  var gameModeL = snapshot.data as gameModel.GamesModel;

                  return ListView.builder(
                      itemCount: gameModeL.results.length,
                      itemBuilder: (context, position){
                        var currentGame = gameModeL.results[position];
                        return InkWell(child: GameView(
                            onSavedTap: (string) {
                              if (string == "Added") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.black,
                                        content: NormalText(text: "Game added to favourite!")
                                    )
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.black,
                                        content: NormalText(text: "Game removed from favourite!")
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
                          },);
                      }
                  );
                }else if(snapshot.hasError){
                  print("Platform Page: ${snapshot.error}");
                  return Container(
                    padding: EdgeInsets.all(20),
                    height: SizeConfig.screenHeightDp,
                    width: SizeConfig.screenWidthDp,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NormalText(text: "Sorry an error occured",textAlign: TextAlign.center,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                loadGamesFuture = getGames();
                              });
                            },
                            child: NormalText(text: "Reload", textColor: Colors.orange, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                } else{
                  return Container(
                    height: SizeConfig.screenHeightDp,
                    width: SizeConfig.screenWidthDp,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
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
