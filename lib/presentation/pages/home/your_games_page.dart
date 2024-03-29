
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/category/genres_page.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class YourGamesPage extends StatefulWidget {
  @override
  _YourGamesPageState createState() => _YourGamesPageState();
}

class _YourGamesPageState extends State<YourGamesPage> {


  @override
  void initState() {
    BlocProvider.of<YourGamesBloc>(context).add(LoadYourGames());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: SizeConfig.screenHeightDp,
              width: SizeConfig.screenWidthDp,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TitleText(text: "Your Games", ),
                            NormalText(text: "Games that match your interests!",),
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
                    YMargin(20),
                    BlocBuilder<YourGamesBloc, YourGamesState>(
                      builder: (context, state){
                        if(state is YourGamesLoadInProgress){
                          return Container(
                            height: SizeConfig.screenHeightDp - 200,
                            width: SizeConfig.screenWidthDp,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }else if(state is YourGamesLoadSuccess){
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.games.results.length,
                              itemBuilder: (context, position){
                                var currentGame = state.games.results[position];
                                return InkWell(child: GameView(
                                    onSavedTap: (string) {
                                      if (string == "Added") {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                elevation: 5,
                                                backgroundColor: Colors.orange,
                                                content: NormalText(text: "Game saved!", textColor: Colors.white)
                                            )
                                        );
                                      } else {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                elevation: 5,
                                                backgroundColor: Colors.orange,
                                                content: NormalText(text: "Game un-saved!", textColor: Colors.white)
                                            )
                                        );
                                      }
                                    },
                                    result: state.games.results[position]),
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
                        }else if(state is YourGamesLoadFailure){
                          return Container(
                            padding: EdgeInsets.all(20),
                            height: SizeConfig.screenHeightDp - 200,
                            width: SizeConfig.screenWidthDp,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  NormalText(text: "Sorry an error occured", textAlign: TextAlign.center,),
                                  GestureDetector(
                                    onTap: (){
                                      BlocProvider.of<YourGamesBloc>(context).add(LoadYourGames());
                                    },
                                    child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Container(
                            height: SizeConfig.screenHeightDp - 200,
                            width: SizeConfig.screenWidthDp,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }

}
