import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_app/models/GamesModel.dart';

class AnticipatedView extends StatefulWidget {

  final Result result;

  AnticipatedView(this.result);

  @override
  _AnticipatedViewState createState() => _AnticipatedViewState();
}

class _AnticipatedViewState extends State<AnticipatedView> {
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
        width: 250,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: widget.result.name,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/placeholder.png",
                imageCacheHeight: 350,
                imageCacheWidth: 700,
                placeholderCacheHeight: 400,
                placeholderCacheWidth: 400,
                image: widget.result.backgroundImage,
                fit: BoxFit.cover, height: 200,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
