
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/models/platform_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';

class PlatformPage extends StatefulWidget {

  final PlatformResult result;

  PlatformPage(this.result);

  @override
  _PlatformPageState createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GamesViaPlatformBloc>(context).add(
        LoadGamesViaPlatforms(widget.result.slug));

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
            return Column(
              children: [
                BlocBuilder<GamesViaPlatformBloc, GamesViaPlatformState>(
                  builder: (context, state){
                    if(state is GamesViaPlatformLoadInProgress){
                      return Container(
                        height: SizeConfig.screenHeightDp,
                        width: SizeConfig.screenWidthDp,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }else if(state is GamesViaPlatformLoadSuccess){
                      return ListView.builder(
                          itemCount: state.gamesDetails.results.length,
                          itemBuilder: (context, position){
                            var currentGame = state.gamesDetails.results[position];
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
                                result: state.gamesDetails.results[position]
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
                    } else if(state is GamesViaPlatformLoadFailure){

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
                                  BlocProvider.of<GamesViaPlatformBloc>(context).add(
                                      LoadGamesViaPlatforms(widget.result.slug));
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
                  }
                ),
              ],
            );
          },
        )
    );
  }
}
