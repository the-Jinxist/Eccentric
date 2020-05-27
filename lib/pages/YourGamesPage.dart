import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class YourGamesPage extends StatefulWidget {
  @override
  _YourGamesPageState createState() => _YourGamesPageState();
}

class _YourGamesPageState extends State<YourGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Your Games", style: Theme.of(context).textTheme.title,),
                      Text("Games that match your interests!", style: Theme.of(context).textTheme.subtitle,),
                    ],
                  ),
                  IconButton(
                    onPressed: (){

                    },
                    icon: Icon(LineAwesomeIcons.gear,),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
