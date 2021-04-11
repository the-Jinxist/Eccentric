
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/view/bland_picture_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/x_margin.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class GameDetailsPage extends StatefulWidget {

  final int id;
  final String name;
  final String slug;
  final String backgroundImage;
  final String releaseDate;
  final int metacriticRating;
  final int playTime;
  final int suggestionsCount;
  final int ratingsTop;
  final int ratingsCount;
  final double rating;

  GameDetailsPage({this.id, this.name, this.slug, this.backgroundImage,
    this.releaseDate, this.metacriticRating, this.playTime, this.suggestionsCount,
    this.ratingsTop, this.ratingsCount, this.rating});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage>
    with SingleTickerProviderStateMixin {

  final SizeConfig _sizeConfig = SizeConfig();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<DetailsBloc>(context).add(LoadDetails(widget.id));
    BlocProvider.of<AchievementBloc>(context).add(LoadAchievement(widget.id));
    BlocProvider.of<ScreenshotBloc>(context).add(LoadScreenshot(widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: BlandPictureView(widget.backgroundImage),
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(text: "${widget.name}", maxLines: 5,),
                    NormalText(text: "Released: ${widget.releaseDate}!",),
                    RatingBar(
                      onRatingUpdate: (rating) {},
                      allowHalfRating: true,
                      itemCount: widget.ratingsTop,
                      itemSize: 20,
                      ignoreGestures: true,
                      initialRating: widget.rating,
                      glow: true,
                      itemBuilder: (context, _) =>
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),

                    )
                  ],
                )
              ),
            ),
          ),

          SliverFillRemaining(
            child: CustomScrollView(
              primary: false,
              slivers:<Widget> [
                SliverPadding(
                  padding: EdgeInsets.only(top: 60, left: 15, right: 15),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        YMargin(20,),
                    TitleText(text: "Description", fontSize: 20,),
                    YMargin(5,),
                    _buildGameDetails(),
                    YMargin(20,),
                    TitleText(text: "Achievements", fontSize: 20,),
                    YMargin(5,),
                    _buildGameAchievements(),
                    YMargin(20,),
                    TitleText(text: "Screenshots", fontSize: 20,),
                    YMargin(5,),
                    _buildGameScreenshots(),
                    YMargin(50,),
                    //TODO: Might add trailer some.
//          Text("Trailers", style: Theme.of(context).textTheme.headline,),
//          _buildGameTrailer(),
                    ],
                    ),
                  ),
                ),
              ],
            )
          )
        ]
      )
    );
      /*ListView(
        padding: EdgeInsets.only(top: 60, left: 15, right: 15),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleText(text: "${widget.name}", maxLines: 5,),
              NormalText(text: "Released: ${widget.releaseDate}!",),
              RatingBar(
                onRatingUpdate: (rating) {},
                allowHalfRating: true,
                itemCount: widget.ratingsTop,
                itemSize: 20,
                ignoreGestures: true,
                initialRating: widget.rating,
                glow: true,
                itemBuilder: (context, _) =>
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),

              )
            ],
          ),
          YMargin(10,),
          Hero(tag: widget.name,
              child: BlandPictureView(widget.backgroundImage)),
          YMargin(20,),
          TitleText(text: "Description", fontSize: 20,),
          YMargin(5,),
          _buildGameDetails(),
          YMargin(20,),
          TitleText(text: "Achievements", fontSize: 20,),
          YMargin(5,),
          _buildGameAchievements(),
          YMargin(20,),
          TitleText(text: "Screenshots", fontSize: 20,),
          YMargin(5,),
          _buildGameScreenshots(),
          YMargin(50,),
          //TODO: Might add trailer some.
//          Text("Trailers", style: Theme.of(context).textTheme.headline,),
//          _buildGameTrailer(),
//          SizedBox(height: 20,),

        ],
      ),
    );*/
  }

  Widget _buildGameDetails() {
    return BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoadInProgress) {
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DetailsLoadSuccess) {
            return Container(
                width: SizeConfig.screenWidthDp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    YMargin(5,),
                    NormalText(text: "${state.gamesDetails.description
                        .replaceAll("<p>", "")
                        .replaceAll("</p>", "")
                        .replaceAll("<br />", "\n")}"),
                    YMargin(15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        state.gamesDetails.website != null ? GestureDetector(
                          onTap: () {
                            if (state.gamesDetails.website != null) {
                              //Navigate to website
                            }
                          },
                          child: Icon(
                            LineAwesomeIcons.internet_explorer, size: 30,
                          ),
                        ): Container(),
                        XMargin(10),
                        state.gamesDetails.redditUrl != null ? GestureDetector(
                          onTap: () {
                            if (state.gamesDetails.redditUrl != null) {
                              //Navigate to website
                            }
                          },
                          child: Icon(
                              LineAwesomeIcons.reddit, size: 30
                          ),
                        ): Container()
                      ],
                    ),
                    YMargin(15,),
                    BlandPictureView(
                      state.gamesDetails.backgroundImageAdditional,),
                  ],
                )
            );
          } else if (state is DetailsLoadFailure) {
            return Container(
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(
                      text: "Sorry an error occurred: ${state.error}",),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<DetailsBloc>(context).add(
                            LoadDetails(widget.id));
                      },
                      child: TitleText(text: "Reload",
                        textColor: Colors.orange,
                        fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildGameAchievements() {
    return BlocBuilder<AchievementBloc, AchievementState>(
        builder: (context, state) {
          if (state is AchievementLoadInProgress) {
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AchievementLoadSuccess) {
            var model = state.achievement;

            return Container(
              width: SizeConfig.screenWidthDp,
              child: model.name == "null" && model.description == "null"
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NormalText(text: "${model.name}",),
                  NormalText(text: "${model.description}",),
                ],
              )
                  : NormalText(text: "No achievements to speak of.. For now",),
            );
          } else if (state is AchievementLoadFailure) {
            return Container(
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalText(
                      text: "Sorry an error occurred: ${state.error}",),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          BlocProvider.of<AchievementBloc>(context).add(
                              LoadAchievement(widget.id));
                        });
                      },
                      child: TitleText(text: "Reload",
                        textColor: Colors.orange,
                        fontSize: 25,),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: _sizeConfig.sh(200),
              width: SizeConfig.screenWidthDp,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget _buildGameScreenshots() {
    return Column(
      children: [
        BlocBuilder<ScreenshotBloc, ScreenshotState>(
            builder: (context, state) {
              if (state is ScreenshotLoadInProgress) {
                return Container(
                  height: _sizeConfig.sh(250),
                  width: SizeConfig.screenWidthDp,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ScreenshotLoadSuccess) {

                var model = state.screenshots;

                return Container(
                  height: _sizeConfig.sh(220),
                  width: SizeConfig.screenWidthDp,
                  child: PageView.builder(
                      itemCount: model.results.length,
                      itemBuilder: (context, position) {
                        return Container(margin: EdgeInsets.only(right: 5,),
                            child: BlandPictureView(
                                model.results[position].image));
                      }),
                );
              }else if(state is ScreenshotLoadFailure){
                return Container(
                  width: SizeConfig.screenWidthDp,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        NormalText(text: "Sorry an error occurred: ${state.error}",),
                        GestureDetector(
                          onTap: () {

                          },
                          child: TitleText(text: "Reload", textColor: Colors
                              .orange, fontSize: 25,),
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return Container(
                  height: _sizeConfig.sh(250),
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

}
