import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/network/rawg_impl.dart' as api;
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/category/anticipated_page.dart';
import 'package:game_app/presentation/pages/category/developers_page.dart';
import 'package:game_app/presentation/pages/category/platform_page.dart';
import 'package:game_app/presentation/pages/category/popular_page.dart';
import 'package:game_app/presentation/pages/category/publishers_page.dart';
import 'package:game_app/presentation/pages/details/game_details_page.dart';
import 'package:game_app/presentation/pages/details/search_page.dart';
import 'package:game_app/presentation/pages/industry/all_developers_page.dart';
import 'package:game_app/presentation/pages/industry/all_publishers_page.dart';
import 'package:game_app/presentation/view/anticipated_view.dart';
import 'package:game_app/presentation/view/platform_view.dart';
import 'package:game_app/presentation/view/popular_view.dart';
import 'package:game_app/presentation/view/publisher_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/x_margin.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DiscoverGamesPage extends StatefulWidget {
  @override
  _DiscoverGamesPageState createState() => _DiscoverGamesPageState();
}

class _DiscoverGamesPageState extends State<DiscoverGamesPage> {
  final SizeConfig _config = SizeConfig();
  AnticipatedBloc anticipatedBloc;

  @override
  void dispose() {
    super.dispose();

    anticipatedBloc.close();
  }

  @override
  void initState() {
    anticipatedBloc = BlocProvider.of<AnticipatedBloc>(context);

    anticipatedBloc.add(LoadAnticipated());
    BlocProvider.of<PublishersBloc>(context).add(LoadPublishers());
    BlocProvider.of<PopularBloc>(context).add(LoadPopular());
    BlocProvider.of<DevelopersBloc>(context).add(LoadDevelopers());
    BlocProvider.of<PlatformBloc>(context).add(LoadPlatform());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: ListView(
        padding: EdgeInsets.only(left: 15, right: 15),
        children: <Widget>[
          YMargin(50),
          TitleText(
            text: "Discover Games",
          ),
          NormalText(
            text: "Find games from all categories",
          ),
          YMargin(30),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Container(
                height: _config.sh(60),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.1)),
                width: SizeConfig.screenWidthDp,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(LineAwesomeIcons.search),
                    XMargin(
                      10,
                    ),
                    NormalText(
                      text: "Search",
                    )
                  ],
                )),
          ),
          YMargin(30),
          //
          //
          // - Popular
          //
          //
          _buildSectionLabel("Popular In ${api.getCurrentYear()}",
              "The biggest games this year!", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PopularPage()));
          }),
          YMargin(15),
          _buildPopularGames(),
          YMargin(40),

          //
          //
          // - Anticipated
          //
          //

          _buildSectionLabel("Anticipated Games in ${api.getCurrentYear()}",
              "We're all waiting for these games", () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AnticipatedPage()));
          }),
          YMargin(15),
          _buildAnticipatedGames(),
          YMargin(40),

          //
          //
          // - Publishers
          //
          //
          _buildSectionLabel("Publishers", "Your favourite game publishers",
              () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AllPublishersPage()));
          }),
          YMargin(15),
          _buildPublishers(),
          YMargin(40),

          //
          //
          // - Developers
          //
          //
          _buildSectionLabel("Developers", "The best, biggest game developers!",
              () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AllDevelopersPage()));
          }),
          YMargin(15),
          _buildDevelopers(),
          YMargin(40),

          //
          //
          // - Platforms
          //
          //
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: "Platforms",
                fontSize: 20,
              ),
              YMargin(5),
              NormalText(
                  text: "All the devices you can play a game on",
                  fontSize: 12
              ),
            ],
          ),
          YMargin(10),
          _buildPlatform(),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NormalText(
                text: "ECCENTRIC V1.1",
              )
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String title, String desc, Function onTapViewMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleText(
              text: "$title",
              fontSize: 20,
            ),
            YMargin(5),
            NormalText(
              text: "$desc",
              fontSize: 12
            ),
          ],
        ),
        InkWell(
            onTap: () {
              onTapViewMore();
            },
            child: TitleText(
              text: "View More",
              textColor: Colors.orange,
              fontSize: 12,
            ))
      ],
    );
  }

  Widget _buildPopularGames() {
    return BlocBuilder<PopularBloc, PopularState>(
        builder: (BuildContext context, PopularState state) {
      if (state is PopularLoadInProgress) {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is PopularLoadSuccess) {
        var models = state.games.results;
        return Container(
          height: _config.sh(220),
          width: SizeConfig.screenWidthDp,
          child: PageView.builder(
              itemCount: 5,
              itemBuilder: (context, position) {
                var model = models[position];
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GameDetailsPage(
                                backgroundImage: model.backgroundImage,
                                id: model.id,
                                metacriticRating: model.metacritic,
                                name: model.name,
                                playTime: model.playtime,
                                rating: model.rating,
                                ratingsCount: model.ratingsCount,
                                ratingsTop: model.ratingsTop,
                                releaseDate: model.released,
                                slug: model.slug,
                                suggestionsCount: model.suggestionsCount,
                              )));
                    },
                    child: PopularView(model));
              }),
        );
      } else if (state is PopularLoadFailure) {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NormalText(
                  text: "Sorry an error occurred",
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<PopularBloc>(context).add(LoadPopular());
                  },
                  child: TitleText(
                    text: "Reload",
                    textColor: Colors.orange,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget _buildAnticipatedGames() {
    return BlocBuilder<AnticipatedBloc, AnticipatedState>(
        builder: (context, state) {
      if (state is AnticipatedLoadInProgress) {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is AnticipatedLoadSuccess) {
        return Container(
          height: _config.sh(220),
          width: SizeConfig.screenWidthDp,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, position) {
                var model = state.games.results[position];
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GameDetailsPage(
                                backgroundImage: model.backgroundImage,
                                id: model.id,
                                metacriticRating: model.metacritic,
                                name: model.name,
                                playTime: model.playtime,
                                rating: model.rating,
                                ratingsCount: model.ratingsCount,
                                ratingsTop: model.ratingsTop,
                                releaseDate: model.released,
                                slug: model.slug,
                                suggestionsCount: model.suggestionsCount,
                              )));
                    },
                    child: AnticipatedView(model));
              }),
        );
      } else {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NormalText(text: "Sorry an error occurred"),
                GestureDetector(
                  onTap: () {
                    anticipatedBloc.add(LoadAnticipated());
                  },
                  child: TitleText(
                    text: "Reload",
                    textColor: Colors.orange,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  Widget _buildPublishers() {
    return BlocBuilder<PublishersBloc, PublishersState>(
        builder: (BuildContext context, PublishersState state) {
      if (state is PublishersLoadInProgress) {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is PublishersLoadSuccess) {
        return Container(
          height: _config.sh(220),
          width: SizeConfig.screenWidthDp,
          child: PageView.builder(
              itemCount: 10,
              itemBuilder: (context, position) {
                var model = state.publishers.results[position];
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PublishersPage(model)));
                    },
                    child: PublisherView(model, "publishers"));
              }),
        );
      } else if (state is PublishersLoadFailure) {
        return Container(
          height: _config.sh(250),
          width: double.maxFinite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NormalText(
                  text: "Sorry an error occurred",
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<PublishersBloc>(context)
                        .add(LoadPublishers());
                  },
                  child: TitleText(
                    text: "Reload",
                    textColor: Colors.orange,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget _buildDevelopers() {
    return BlocBuilder<DevelopersBloc, DevelopersState>(
        builder: (BuildContext context, DevelopersState state) {
      if (state is DevelopersLoadInProgress) {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is DevelopersLoadSuccess) {
        return Container(
          height: _config.sh(220),
          width: SizeConfig.screenWidthDp,
          child: PageView.builder(
              itemCount: 10,
              itemBuilder: (context, position) {
                var model = state.developers.results[position];
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DevelopersPage(model)));
                    },
                    child: PublisherView(model, "developers"));
              }),
        );
      } else if (state is DevelopersLoadFailure) {
        return Container(
          height: _config.sh(250),
          width: double.maxFinite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NormalText(
                  text: "Sorry an error occurred",
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<DevelopersBloc>(context)
                        .add(LoadDevelopers());
                  },
                  child: TitleText(
                    text: "Reload",
                    textColor: Colors.orange,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Container(
          height: _config.sh(250),
          width: SizeConfig.screenWidthDp,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget _buildPlatform() {
    return Column(
      children: [
        BlocBuilder<PlatformBloc, PlatformState>(
            builder: (BuildContext context, PlatformState state) {
          if (state is PlatformLoadInProgress) {
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is PlatformLoadSuccess) {
            return Container(
              height: _config.sh(220),
              width: SizeConfig.screenWidthDp,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.platforms.results.length,
                  itemBuilder: (context, position) {
                    var model = state.platforms.results[position];
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlatformPage(model)));
                        },
                        child: PlatformView(model));
                  }),
            );
          } else if (state is PlatformLoadFailure) {
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(
                      text: "Sorry an error occurred",
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<PlatformBloc>(context)
                            .add(LoadPlatform());
                      },
                      child: TitleText(
                        text: "Reload",
                        textColor: Colors.orange,
                        fontSize: 25,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }),
      ],
    );
  }
}
