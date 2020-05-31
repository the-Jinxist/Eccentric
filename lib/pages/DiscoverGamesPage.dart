import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 40, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Discover", style: Theme.of(context).textTheme.title,),
              Text("Find games from all categories..", style: Theme.of(context).textTheme.subtitle,),
              SizedBox(height: 20),
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.withOpacity(0.3)
                ),
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(LineAwesomeIcons.search),
                    SizedBox(width: 10,),
                    Text("Search", style: Theme.of(context).textTheme.subtitle,)
                  ],
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}
