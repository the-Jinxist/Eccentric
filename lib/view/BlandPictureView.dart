import 'package:flutter/material.dart';


class BlandPictureView extends StatelessWidget {

  final String imageString;

  BlandPictureView(this.imageString);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        height: 400,
        child: FadeInImage.assetNetwork(
          placeholder: "assets/images/placeholder.png",
          image: imageString,
          fit: BoxFit.cover,
          height: 400,
          width: double.maxFinite,),
      ),
    );
  }
}
