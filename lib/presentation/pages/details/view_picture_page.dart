import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_app/domain/utils/navigator.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ViewPicturePage extends StatefulWidget {

  final List<String> pictureUrls;
  final int startPosition;

  ViewPicturePage({@required this.pictureUrls, this.startPosition = 0});

  @override
  _ViewPicturePageState createState() => _ViewPicturePageState();
}

class _ViewPicturePageState extends State<ViewPicturePage> {


  final SizeConfig _config = SizeConfig();
  PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: widget.startPosition, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light
      )
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(LineAwesomeIcons.backward, color: Colors.white,), onPressed: (){
          popView(context);
        }),
      ),
      body: Container(
        height: SizeConfig.screenHeightDp,
        width: SizeConfig.screenWidthDp,
        color: Colors.black,
        child: PageView.builder(
          itemCount: widget.pictureUrls.length,
          pageSnapping: true,
          controller: _controller,
          itemBuilder: (BuildContext context, int position){
            return FadeInImage.assetNetwork(
              placeholder: "assets/images/placeholder.png",
              image: widget.pictureUrls[position],
              placeholderCacheHeight: _config.sh(250).toInt(),
              placeholderCacheWidth: SizeConfig.screenWidthDp.toInt(),
              fit: BoxFit.cover,
              width: SizeConfig.screenWidthDp,
            );
          }
        )
      ),
    );
  }
}
