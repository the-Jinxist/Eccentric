import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/domain/models/GamesModel.dart';

class PopularView extends StatefulWidget {

  final Result result;

  PopularView(this.result);

  @override
  _PopularViewState createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.only(right: 5, bottom: 5),
      child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: widget.result.name,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder.png",
                  image: widget.result.backgroundImage,
                  fit: BoxFit.cover, height: 200,
                  imageCacheHeight: 450,
                  imageCacheWidth: 800,
                  placeholderCacheHeight: 400,
                  placeholderCacheWidth: 400,
                  width: MediaQuery.of(context).size.width,),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black
                        ],
                        stops: [
                          0.2,
                          1.0
                        ]
                    )
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text("${widget.result.name}",
                      style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    RatingBar(
                      onRatingUpdate: (rating){

                      },
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: widget.result.ratingsTop,
                      tapOnlyMode: false,
                      direction: Axis.horizontal,
                      initialRating: widget.result.rating,
                    ),
                  ],
                )
              )
            ],
          ),
      ),
    );
  }
}
