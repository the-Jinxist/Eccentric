import 'package:flutter/material.dart';
import 'package:game_app/domain/utils/size_config.dart';


class BlandPictureView extends StatelessWidget {

  final String imageString;

  BlandPictureView(this.imageString);

  final SizeConfig _config = SizeConfig();

  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: _config.sh(250),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/images/placeholder.png",
          image: imageString,
          placeholderCacheHeight: _config.sh(400).toInt(),
          placeholderCacheWidth: _config.sw(400).toInt(),
          fit: BoxFit.cover,
          height: _config.sh(400),
          width: SizeConfig.screenWidthDp,),
      ),
    );
  }
}
