import 'package:flutter/material.dart';
import 'package:game_app/models/GameModel.dart';
import 'package:game_app/models/DatabaseModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class SavedGamesPage extends StatefulWidget {
  @override
  _SavedGamesPageState createState() => _SavedGamesPageState();
}

class _SavedGamesPageState extends State<SavedGamesPage> {
  List<Result> resultList;
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: databaseHelper.getResult(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              child: Text('Success'),
            );
          } else
            return Container(
              child: Center(child: Text('error', style: TextStyle(color: Colors.black),)),
            );
        },),
//      body: SingleChildScrollView(
//          child: Container(
//            color: Colors.white,
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
//            padding: EdgeInsets.only(top: 40, left: 15, right: 15),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text("Saved Game", style: Theme
//                    .of(context)
//                    .textTheme
//                    .title,),
//                Text("You've taken a fancy to these, I see", style: Theme
//                    .of(context)
//                    .textTheme
//                    .subtitle,),
//              ],
//            ),
//          )
//      ),
    );
  }

  updatescreen() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Result>> gameList = databaseHelper.getResult();
      gameList.then((resultList) {
        setState(() {
          this.resultList = resultList;
          this.count = resultList.length;
        });
      });
    });
  }
}
