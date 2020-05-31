import 'package:flutter/material.dart';
import 'package:game_app/GameView.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/pages/GenresPage.dart';

class YourGamesPage extends StatefulWidget {
  @override
  _YourGamesPageState createState() => _YourGamesPageState();
}

class _YourGamesPageState extends State<YourGamesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Your Games", style: Theme.of(context).textTheme.title,),
                  Text("Games that match your interests!", style: Theme.of(context).textTheme.subtitle,),
                ],
              ),
              IconButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GenresPage()));
                },
                icon: Icon(LineAwesomeIcons.gear,),
              )
            ],
          ),
        ), preferredSize: Size.fromHeight(100)),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, position){
            return GameView();
          },
        ),
      ),
    );
  }
}
