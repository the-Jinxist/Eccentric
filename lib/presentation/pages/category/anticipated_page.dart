import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';

class AnticipatedPage extends StatefulWidget {
  @override
  _AnticipatedPageState createState() => _AnticipatedPageState();
}

class _AnticipatedPageState extends State<AnticipatedPage> {
  @override
  void initState() {
    BlocProvider.of<AnticipatedBloc>(context).add(LoadAnticipated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Container(
              height: SizeConfig.screenHeightDp,
              width: SizeConfig.screenWidthDp,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    YMargin(50),
                    TitleText(
                      text: "Anticipated Games",
                    ),
                    NormalText(
                      text: "Everybody's waiting these ones. Yay",
                    ),
                    YMargin(15),
                    BlocBuilder<AnticipatedBloc, AnticipatedState>(
                      builder: (BuildContext context, AnticipatedState state) {
                        if (state is AnticipatedLoadInProgress) {
                          return Container(
                            height: SizeConfig.screenHeightDp - 200,
                            width: SizeConfig.screenWidthDp,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is AnticipatedLoadSuccess) {
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.games.results.length,
                              itemBuilder: (context, position) {
                                var currentGame = state.games.results[position];
                                return InkWell(
                                  child: GameView(
                                      onSavedTap: (string) {
                                        if (string == "Added") {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: NormalText(
                                                    text:
                                                        "Game added to favourite!",
                                                    textColor: Colors.white,
                                                  )));
                                        } else {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: NormalText(
                                                    text:
                                                        "Game removed from favourite!",
                                                    textColor: Colors.white,
                                                  )));
                                        }
                                      },
                                      result: state.games.results[position]),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GameDetailsPage(
                                                  backgroundImage: currentGame
                                                      .backgroundImage,
                                                  id: currentGame.id,
                                                  metacriticRating:
                                                      currentGame.metacritic,
                                                  name: currentGame.name,
                                                  playTime:
                                                      currentGame.playtime,
                                                  rating: currentGame.rating,
                                                  ratingsCount:
                                                      currentGame.ratingsCount,
                                                  ratingsTop:
                                                      currentGame.ratingsTop,
                                                  releaseDate:
                                                      currentGame.released,
                                                  slug: currentGame.slug,
                                                  suggestionsCount: currentGame
                                                      .suggestionsCount,
                                                )));
                                  },
                                );
                              });
                        } else if (state is AnticipatedLoadFailure) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            height: SizeConfig.screenHeightDp - 200,
                            width: SizeConfig.screenWidthDp,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  NormalText(
                                    text: "Sorry an error occured",
                                    textAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<AnticipatedBloc>(context)
                                          .add(LoadAnticipated());
                                    },
                                    child: NormalText(
                                      text: "Reload",
                                      textColor: Colors.orange,
                                      fontSize: 25,
                                    ),
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
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
