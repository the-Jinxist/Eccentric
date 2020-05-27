import 'package:flutter/material.dart';

class DiscoverGamesPage extends StatefulWidget {
  @override
  _DiscoverGamesPageState createState() => _DiscoverGamesPageState();
}

class _DiscoverGamesPageState extends State<DiscoverGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 40, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Discover", style: Theme.of(context).textTheme.title,),
              Text("Find games from all categories..", style: Theme.of(context).textTheme.subtitle,),
            ],
          ),
        )
      ),
    );
  }
}
