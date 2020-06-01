import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_app/models/GameModel.dart';
import 'package:game_app/models/PlatformModel.dart';
import 'package:game_app/models/PublishersModel.dart';
import 'package:game_app/view/AnticipatedView.dart';
import 'package:game_app/view/PlatformView.dart';
import 'package:game_app/view/PopularView.dart';
import 'package:game_app/view/PublisherView.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/api/RawgApi.dart' as api;

class DiscoverGamesPage extends StatefulWidget {
  @override
  _DiscoverGamesPageState createState() => _DiscoverGamesPageState();
}

class _DiscoverGamesPageState extends State<DiscoverGamesPage> {

  Future popularFuture;
  Future publisherFuture;
  Future developerFuture;
  Future platformFuture;
  Future anticipatedFuture;

  @override
  void initState() {
    popularFuture = _getPopularGames();
    publisherFuture = _getPublishers();
    developerFuture = _getDevelopers();
    platformFuture = _getPlatforms();
    anticipatedFuture = _getAnticipatedGames();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Discover Game", style: Theme.of(context).textTheme.title,),
              Text("Find games from all categories", style: Theme.of(context).textTheme.subtitle,),
            ],
          ),
        ), preferredSize: Size.fromHeight(100)),
      body: ListView(
        padding: EdgeInsets.only( left: 15, right: 15),
        children: <Widget>[
          Container(
              height: 60,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.withOpacity(0.3)
              ),
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(LineAwesomeIcons.search),
                  SizedBox(width: 10,),
                  Text("Search", style: Theme.of(context).textTheme.subtitle,)
                ],
              )
          ),
          SizedBox(height: 30),
          //
          //
          // - Popular
          //
          //
          _buildSectionLabel("Popular In 2020", "The biggest games this year!", (){}),
          SizedBox(height: 10),
          _buildPopularGames(),
          SizedBox(height: 20),

          //
          //
          // - Anticipated
          //
          //

          _buildSectionLabel("Anticipated Games in 2020", "We're all waiting for these games", (){}),
          SizedBox(height: 10),
          _buildAnticipatedGames(),
          SizedBox(height: 20),

          //
          //
          // - Publishers
          //
          //
          _buildSectionLabel("Publishers", "Your favourite game publishers", (){}),
          SizedBox(height: 10),
          _buildPublishers(),
          SizedBox(height: 20),

          //
          //
          // - Developers
          //
          //
          _buildSectionLabel("Developers", "The best, biggest game developers!", (){}),
          SizedBox(height: 10),
          _buildDevelopers(),
          SizedBox(height: 20),

          //
          //
          // - Platforms
          //
          //
          _buildSectionLabel("Platforms", "Every device you play a game on!", (){}),
          SizedBox(height: 10),
          _buildPlatform(),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("ECCENTRIC V1.0", style: Theme.of(context).textTheme.display1.copyWith(color: Colors.orange),)
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
            Text("$title", style: Theme.of(context).textTheme.headline,),
            Text("$desc", style: Theme.of(context).textTheme.display2,),
          ],
        ),
        InkWell(
          onTap: (){
            onTapViewMore();
          },
          child: Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),))
      ],
    );
  }

  Widget _buildPopularGames(){
    return FutureBuilder(
        future: popularFuture,
        builder: (context, snapshot){
          if(snapshot.hasData){
            var models = (snapshot.data as GameModel).results;
            return Container(
              height: 200,
              width: double.maxFinite,
              child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, position){
                    var model = models[Random().nextInt(models.length - 1)];
                    return PopularView(model);
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          popularFuture = _getPopularGames();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 20),),
                    )
                  ],
                ),
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildAnticipatedGames(){
    return FutureBuilder(
        future: anticipatedFuture,
        builder: (context, snapshot){
          if(snapshot.hasData){
            var models = (snapshot.data as GameModel).results;
            return Container(
              height: 200,
              width: double.maxFinite,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, position){
                    var model = models[Random().nextInt(models.length - 1)];
                    return AnticipatedView(model);
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          anticipatedFuture = _getAnticipatedGames();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 20),),
                    )
                  ],
                ),
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildPublishers(){
    return FutureBuilder(
        future: publisherFuture,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: PageView.builder(
                  itemCount: 10,
                  itemBuilder: (context, position){
                    var model = (snapshot.data as PublishersModel).results[position];
                    return PublisherView(model);
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          publisherFuture = _getPublishers();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 20),),
                    )
                  ],
                ),
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
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
          if(snapshot.hasData){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: PageView.builder(
                  itemCount: 10,
                  itemBuilder: (context, position){
                    var model = (snapshot.data as PublishersModel).results[position];
                    return PublisherView(model);
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          developerFuture = _getDevelopers();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 20),),
                    )
                  ],
                ),
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
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
          if(snapshot.hasData){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, position){
                    var model = (snapshot.data as PlatformModel).results[position];
                    return PlatformView(model);
                  }),
            );
          }else if(snapshot.hasError){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occurred", style: Theme.of(context).
                    textTheme.display1,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          platformFuture = _getPlatforms();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 20),),
                    )
                  ],
                ),
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else{
            return Container(
              height: 200,
              width: double.maxFinite,
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

  Future<GameModel> _getPopularGames() async{
    var response = await api.getPopular();
    if(response.statusCode == 200){
      var model = GameModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("Discover - Popular Error: ${response.statusCode}");
      return null;
    }

  }

  Future<GameModel> _getAnticipatedGames() async{
    var response = await api.getAnticipated();
    if(response.statusCode == 200){
      var model = GameModel.fromJson(json.decode(response.body));
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
