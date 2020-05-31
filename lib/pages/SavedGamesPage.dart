import 'package:flutter/material.dart';

class SavedGamesPage extends StatefulWidget {
  @override
  _SavedGamesPageState createState() => _SavedGamesPageState();
}

class _SavedGamesPageState extends State<SavedGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Saved Game", style: Theme.of(context).textTheme.title,),
                Text("You've taken a fancy to these, I see", style: Theme.of(context).textTheme.subtitle,),
              ],
            ),
          )
      ),
    );
  }
}
