import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class BlandPictureView extends StatelessWidget {

  final String imageString;

  BlandPictureView(this.imageString);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: 200,
        child: CachedNetworkImage(
          height: 200,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl: imageString,
          placeholder: (context, url){
            return Image.asset("assets/images/placeholder.png", fit: BoxFit.cover, height: 200,
              width: MediaQuery.of(context).size.width,);
          },
        )
      ),
    );
  }
}
