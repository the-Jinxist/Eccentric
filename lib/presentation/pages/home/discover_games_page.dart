import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart' as api;
import 'package:game_app/domain/models/games_model.dart';
import 'package:game_app/domain/models/platform_model.dart';
import 'package:game_app/domain/models/publishers_model.dart';
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

  Future popularFuture;
  Future publisherFuture;
  Future developerFuture;
  Future platformFuture;

  final SizeConfig _config = SizeConfig();

  AnticipatedBloc anticipatedBloc;

  @override
  void dispose() {
    super.dispose();

    anticipatedBloc.close();
  }

  @override
  void initState() {
    popularFuture = _getPopularGames();
    publisherFuture = _getPublishers();
    developerFuture = _getDevelopers();
    platformFuture = _getPlatforms();

    anticipatedBloc = BlocProvider.of<AnticipatedBloc>(context);
    anticipatedBloc.add(LoadAnticipated());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: PreferredSize(child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleText(text: "Discover Games",),
              NormalText(text: "Find games from all categories", ),
            ],
          ),
        ), preferredSize: Size.fromHeight(100)),
      body: ListView(
        padding: EdgeInsets.only( left: 15, right: 15),
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Container(
                height: _config.sh(70),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey.withOpacity(0.3)
                ),
                width: SizeConfig.screenWidthDp,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(LineAwesomeIcons.search),
                    XMargin(10,),
                    NormalText(text: "Search",)
                  ],
                )
            ),
          ),
          YMargin(30),
          //
          //
          // - Popular
          //
          //
          _buildSectionLabel("Popular In ${api.getCurrentYear()}", "The biggest games this year!", (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PopularPage()));
          }),
          YMargin(10),
          _buildPopularGames(),
          YMargin(20),

          //
          //
          // - Anticipated
          //
          //

          _buildSectionLabel("Anticipated Games in ${api.getCurrentYear()}", "We're all waiting for these games", (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnticipatedPage()));
          }),
          YMargin(10),
          _buildAnticipatedGames(),
          YMargin(20),

          //
          //
          // - Publishers
          //
          //
          _buildSectionLabel("Publishers", "Your favourite game publishers", (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllPublishersPage()));
          }),
          YMargin(10),
          _buildPublishers(),
          YMargin(20),

          //
          //
          // - Developers
          //
          //
          _buildSectionLabel("Developers", "The best, biggest game developers!", (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDevelopersPage()));
          }),
          YMargin(10),
          _buildDevelopers(),
          YMargin(20),

          //
          //
          // - Platforms
          //
          //
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(text: "Platforms", fontSize: 20,),
              NormalText(text: "All the devices you play a game on", ),
            ],
          ),
          YMargin(10),
          _buildPlatform(),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NormalText(text: "ECCENTRIC V1.0",)
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }


  Widget _buildSectionLabel(String title,String desc, Function onTapViewMore){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleText(text: "$title", ),
            NormalText(text: "$desc",),
          ],
        ),
        InkWell(
          onTap: (){
            onTapViewMore();
          },
          child: TitleText(text: "View More", textColor: Colors.orange, fontSize: 12,))
      ],
    );
  }

  Widget _buildPopularGames(){
    return FutureBuilder(
        future: popularFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            var models = (snapshot.data as GamesModel).results;
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, position){
                    var model = models[position];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameDetailsPage(
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
                      child: PopularView(model)
                    );
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          popularFuture = _getPopularGames();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildAnticipatedGames(){
    return Column(
      children: [
        BlocBuilder(
          builder: (context, state) {
            if(state is AnticipatedLoadInProgress){
              return Container(
                height: _config.sh(250),
                width: SizeConfig.screenWidthDp,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else if(state is AnticipatedLoadSuccess){
              return Container(
                height: _config.sh(250),
                width: SizeConfig.screenWidthDp,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, position){
                      var model = state.games.results[position];
                      return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameDetailsPage(
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
                          child: AnticipatedView(model)
                      );
                    }),
              );
            }else{
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
                        child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 12,),
                      )
                    ],
                  ),
                ),
              );
            }
          }
        ),
      ],
    );
  }

  Widget _buildPublishers(){
    return FutureBuilder(
        future: publisherFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: PageView.builder(
                  itemCount: 10,
                  itemBuilder: (context, position){
                    var model = (snapshot.data as PublishersModel).results[position];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PublishersPage(model)));
                      },
                      child: PublisherView(model, "publishers")
                    );
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: _config.sh(250),
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          publisherFuture = _getPublishers();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildDevelopers(){
    return FutureBuilder(
        future: developerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: PageView.builder(
                  itemCount: 10,
                  itemBuilder: (context, position){
                    var model = (snapshot.data as PublishersModel).results[position];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DevelopersPage(model)));
                      },
                      child: PublisherView(model, "developers")
                    );
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: _config.sh(250),
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          developerFuture = _getDevelopers();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildPlatform(){
    return FutureBuilder(
        future: platformFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(snapshot.hasData){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: (snapshot.data as PlatformModel).results.length,
                  itemBuilder: (context, position){
                    var model = (snapshot.data as PlatformModel).results[position];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlatformPage(model)));
                      },
                      child: PlatformView(model)
                    );
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(text: "Sorry an error occurred",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          platformFuture = _getPlatforms();
                        });
                      },
                      child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              height: _config.sh(250),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

//  Future<GameModel>_buildAnticipatedGames() async{
//    var response = await api.getPopular();
//    if(response.statusCode == 200){
//      var model = GameModel.fromJson(json.decode(response.body));
//      return model;
//    }else{
//      print("Discover - Popular Error: ${response.statusCode}")
//      return null;
//    }
//
//  }

  Future<GamesModel> _getPopularGames() async{
    var response = await api.getPopular();
    if(response.statusCode == 200){
      var model = GamesModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<PublishersModel>_getDevelopers() async{
    var response = await api.getDevelopers();
    if(response.statusCode == 200){
      var model = PublishersModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<PublishersModel>_getPublishers() async{
    var response = await api.getPublishers();
    if(response.statusCode == 200){
      var model = PublishersModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<PlatformModel>_getPlatforms() async{
    var response = await api.getPlatforms();
    if(response.statusCode == 200){
      var model = PlatformModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

}
