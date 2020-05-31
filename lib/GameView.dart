import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset("assets/images/kratos.jpg", height: 400, width: double.maxFinite, fit: BoxFit.cover, ),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                onPressed: (){

                },
                tooltip: "Save Game",
                icon: Icon(LineAwesomeIcons.heart, color: Colors.white,),
              ),

            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("God Of War IV",
                    style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text("The 6th installment in the God of War series. Won Game of the year",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}
