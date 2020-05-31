import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/GameView.dart';
import 'package:game_app/models/GameModel.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/repo/PrefsRepo.dart' as repo;
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/pages/GenresPage.dart';

class YourGamesPage extends StatefulWidget {
  @override
  _YourGamesPageState createState() => _YourGamesPageState();
}

class _YourGamesPageState extends State<YourGamesPage> {
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
        body: FutureBuilder(
          future: getGames(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var gameModel = snapshot.data as GameModel;

              return ListView.builder(
                itemCount: gameModel.results.length,
                itemBuilder: (context, position){
                  return GameView(gameModel.results[position]);
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
                      Text("Sorry an error occured:\n${snapshot.error.toString()}", textAlign: TextAlign.center,),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
                          getGames();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          elevation: 5,
                          color: Colors.orange,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("Reload", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
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
      ),
    );
  }

  Future<GameModel> getGames() async {

    var genreString = await repo.getGenreString();
    var response  = await api.getGames(genreString);

    if (response.statusCode == 200){
      var responseBody = json.decode(response.body);
      print("Game Model: ${GameModel.fromJson(responseBody).results[3].slug}");
      return GameModel.fromJson(responseBody);
    }else{
      print("Game Model Error: ${response.statusCode}");
      return null;
    }
  }
}
