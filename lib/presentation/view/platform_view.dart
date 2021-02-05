import 'package:flutter/material.dart';
import 'package:game_app/domain/models/platform_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/widgets/texts.dart';

class PlatformView extends StatefulWidget {

  final PlatformResult result;

  PlatformView(this.result);

  @override
  _PlatformViewState createState() => _PlatformViewState();
}

class _PlatformViewState extends State<PlatformView> {

  final SizeConfig _config =SizeConfig();

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
        height: _config.sh(100),
        width: _config.sw(200),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: "assets/images/placeholder.png",
              imageCacheHeight: _config.sh(450),
              imageCacheWidth: _config.sw(800),
              placeholderCacheHeight: _config.sh(400),
              placeholderCacheWidth: _config.sw(400),
              image: widget.result.imageBackground,
              fit: BoxFit.cover, height: _config.sh(200),
              width: SizeConfig.screenWidthDp,),
            Container(
              height: _config.sh(200),
              width: SizeConfig.screenWidthDp,
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
                    TitleText(text: "${widget.result.name}",
                      textColor: Colors.white,
                      textAlign: TextAlign.start,
                    ),
                    NormalText(
                      text: "Games: ${widget.result.gamesCount}",
                      textColor: Colors.white,
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
