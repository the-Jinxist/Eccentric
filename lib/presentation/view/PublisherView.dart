import 'package:flutter/material.dart';
import 'package:game_app/domain/models/PublishersModel.dart';

class PublisherView extends StatefulWidget {

  final Result result;
  final String type;

  PublisherView(this.result, this.type);

  @override
  _PublisherViewState createState() => _PublisherViewState();
}

class _PublisherViewState extends State<PublisherView> {
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
            FadeInImage.assetNetwork(
              placeholder: "assets/images/placeholder.png",
              image: widget.result.imageBackground,
              imageCacheHeight: 450,
              imageCacheWidth: 800,
              placeholderCacheHeight: 400,
              placeholderCacheWidth: 400,
              fit: BoxFit.cover, height: 200,
              width: double.maxFinite,),
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
                    Text("Games: ${widget.result.gameCount}",
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
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
