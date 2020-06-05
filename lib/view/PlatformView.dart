import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_app/models/PlatformModel.dart';

class PlatformView extends StatefulWidget {

  final Result result;

  PlatformView(this.result);

  @override
  _PlatformViewState createState() => _PlatformViewState();
}

class _PlatformViewState extends State<PlatformView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.only(right: 5, bottom: 5),
      child: Container(
        height: 100,
        width: 200,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CachedNetworkImage(
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              imageUrl: widget.result.image != null ? widget.result.image: "wfwf",
              placeholder: (context, url){
                return Image.asset("assets/images/placeholder.png", fit: BoxFit.cover, height: 200,
                  width: MediaQuery.of(context).size.width,);
              },
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
                    Text("Games: ${widget.result.gamesCount}",
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
