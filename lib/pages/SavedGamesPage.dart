import 'package:flutter/material.dart';
import 'package:game_app/models/GamesModel.dart';
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
