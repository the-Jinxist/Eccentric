import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart' as api;
import 'package:game_app/domain/models/games_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';

class PopularPage extends StatefulWidget {
  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PopularBloc>(context).add(
        LoadPopular());

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
                TitleText(text: "Popular in 2020", ),
                NormalText(text: "Everybody's playing these game. Ugh!",),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100)
      ),
        body: Builder(
            builder: (context){
              return Column(
                children: [
                  BlocBuilder<PopularBloc, PopularState>(
                    builder: (context, state){
                      if(state is PopularLoadInProgress){
                        return Container(
                          height: SizeConfig.screenHeightDp,
                          width: SizeConfig.screenWidthDp,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }else if(state is PopularLoadSuccess){

                        return ListView.builder(
                            itemCount: state.games.results.length,
                            itemBuilder: (context, position){
                              var currentGame = state.games.results[position];
                              return InkWell(child: GameView(result: state.games.results[position],
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

                      }else if(state is PopularLoadFailure){
                        return Container(
                          padding: EdgeInsets.all(20),
                          height: SizeConfig.screenHeightDp,
                          width: SizeConfig.screenWidthDp,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                NormalText(text: "Sorry an error occured", textAlign: TextAlign.center,),
                                GestureDetector(
                                  onTap: (){
                                    BlocProvider.of<PopularBloc>(context).add(
                                        LoadPopular());
                                  },
                                  child: NormalText(text: "Reload", textColor: Colors.orange, fontSize: 25, ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return Container(
                          height: SizeConfig.screenHeightDp,
                          width: SizeConfig.screenWidthDp,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }
                  ),
                ],
              );
            }
        )
    );
  }
}
