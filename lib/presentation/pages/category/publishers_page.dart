import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/models/publishers_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/view/game_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';

class PublishersPage extends StatefulWidget {
  final PublishersResult result;

  PublishersPage(this.result);

  @override
  _PublishersPageState createState() => _PublishersPageState();
}

class _PublishersPageState extends State<PublishersPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GamesViaPublishersBloc>(context)
        .add(LoadGamesViaPublishers(widget.result.slug));
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
                    NormalText(
                      text: "Games from",
                    ),
                    TitleText(
                      text: "${widget.result.name}",
                    ),
                    YMargin(15),
                    BlocBuilder<GamesViaPublishersBloc,
                        GamesViaPublishersState>(
                      builder: (BuildContext context, state) {
                        if (state is GamesViaPublishersLoadInProgress) {
                          return Container(
                            height: SizeConfig.screenHeightDp - 300,
                            width: SizeConfig.screenWidthDp,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is GamesViaPublishersLoadSuccess) {
                          return ListView.builder(
                              itemCount: state.games.results.length,
                              itemBuilder: (context, position) {
                                var currentGame = state.games.results[position];
                                return InkWell(
                                  child: GameView(
                                      onSavedTap: (string) {
                                        if (string == "Added") {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: NormalText(
                                                      text:
                                                          "Game added to favourite!")));
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: NormalText(
                                                      text:
                                                          "Game removed from favourite!")));
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
                        } else if (state is GamesViaPublishersLoadFailure) {
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
                                      BlocProvider.of<GamesViaPublishersBloc>(
                                              context)
                                          .add(LoadGamesViaPublishers(
                                              widget.result.slug));
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
