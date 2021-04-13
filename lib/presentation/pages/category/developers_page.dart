
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/models/publishers_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';

class DevelopersPage extends StatefulWidget {

  final PublishersResult result;

  DevelopersPage(this.result);

  @override
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GamesViaDevelopersBloc>(context).add(
        LoadGamesViaDevelopers(widget.result.slug));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                YMargin(50),
                NormalText(text: "Games from",),
                TitleText(text: "${widget.result.name}",),
                YMargin(10),
                Builder(
                  builder: (context) {
                    return BlocBuilder<GamesViaDevelopersBloc, GamesViaDevelopersState>(
                        builder: (context, GamesViaDevelopersState state) {
                          if (state is GamesViaDevelopersLoadInProgress) {
                            return Container(
                              height: SizeConfig.screenHeightDp - 200,
                              width: SizeConfig.screenWidthDp,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is GamesViaDevelopersLoadSuccess) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.games.results.length,
                                itemBuilder: (context, position) {
                                  var currentGame = state.games.results[position];
                                  return InkWell(child: GameView(
                                      onSavedTap: (string) {
                                        if (string == "Added") {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: NormalText(
                                                    text: "Game added to favourite!",
                                                    textColor: Colors.white,)
                                              )
                                          );
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: NormalText(
                                                    text: "Game removed from favourite!",
                                                    textColor: Colors.white,)
                                              )
                                          );
                                        }
                                      },
                                      result: state.games.results[position]),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>
                                              GameDetailsPage(
                                                backgroundImage: currentGame
                                                    .backgroundImage,
                                                id: currentGame.id,
                                                metacriticRating: currentGame
                                                    .metacritic,
                                                name: currentGame.name,
                                                playTime: currentGame.playtime,
                                                rating: currentGame.rating,
                                                ratingsCount: currentGame
                                                    .ratingsCount,
                                                ratingsTop: currentGame.ratingsTop,
                                                releaseDate: currentGame.released,
                                                slug: currentGame.slug,
                                                suggestionsCount: currentGame
                                                    .suggestionsCount,
                                              )));
                                    },);
                                }
                            );
                          } else if (state is GamesViaDevelopersLoadFailure) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              height: SizeConfig.screenHeightDp - 200,
                              width: SizeConfig.screenWidthDp,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    NormalText(text: "Sorry an error occured",
                                      textAlign: TextAlign.center,),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<GamesViaDevelopersBloc>(
                                            context).add(LoadGamesViaDevelopers());
                                      },
                                      child: NormalText(text: "Reload",
                                        textColor: Colors.orange,
                                        fontSize: 25,),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: SizeConfig.screenHeightDp - 200,
                              width: SizeConfig.screenWidthDp,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        }
                    );
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
