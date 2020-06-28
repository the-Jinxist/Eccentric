import 'package:game_app/repo/AuthRepo.dart';
import 'package:game_app/repo/DatabaseRepo.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'GamesModel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String gameTable = 'GameTable';
  String colId = 'id';
  String colSlug = 'slug';
  String colName = 'name';
  String colReleased = 'released';
  String colTba = 'tba';
  String colBackgroundImage = 'backgroundImage';
  String colRating = 'rating';
  String colRatingsTop = 'ratingTop';
  String colRatings = 'ratings';
  String colRatingsCount = 'ratingsCount';
  String colReviewsTextCount = 'reviewsTextCount';
  String colAdded = 'added';
  String colAddedByStatus = 'addedByStatus';
  String colMetacritic = 'metacritic';
  String colPlaytime = 'playtime';
  String colSuggestionsCount = 'suggestionsCount';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if( _database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'game.db';

    var gameDatabase = await openDatabase(path, version: 1, onCreate: createDb);
    return gameDatabase;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $gameTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colAdded INTEGER, $colAddedByStatus TEXT,$colBackgroundImage TEXT, $colMetacritic INTEGER, $colName TEXT, $colPlaytime INTEGER, $colRating DOUBLE, $colRatings TEXT, $colRatingsCount INTEGER, $colRatingsTop INTEGER, $colReleased TEXT, $colReviewsTextCount INTEGER, $colSlug TEXT, $colSuggestionsCount INTEGER, $colTba TEXT)');
  }

  Future<List<Map<String, dynamic>>> getGameList() async{
    Database db = await this.database;

    var result = await db.query(gameTable);

    return result;
  }

  Future<List<Map<String, dynamic>>> getGame(String slug) async{
    Database db = await this.database;
    var result = await db.query(gameTable, where: "$colSlug = ?", whereArgs: [slug]);

    return result;
  }

  Future<int> insert(Result results) async{
    Database db = await this.database;

    var result = await db.insert(gameTable, results.toMap());


    var user = await AuthRepo.getCurrentUser();
    if(user != null){
      var map = await DatabaseHelper().getGameList();
      DatabaseRepo.storeSavedGames(userID: user.uid, savedGames: map);
    }

    return result;
  }
  
  Future<int> delete(int id) async{
    Database db = await this.database;
    
    var result =  await db.delete(gameTable, where: "$colId = ?", whereArgs: [id]);

    var user = await AuthRepo.getCurrentUser();
    if(user != null){
      var map = await DatabaseHelper().getGameList();
      DatabaseRepo.storeSavedGames(userID: user.uid, savedGames: map);
    }

    return result;
  }

  Future<List<Result>> getResult() async{
    var gameMapList = await getGameList();

    int count = gameMapList.length;

    List<Result> list = List<Result>();

    for (int i = 0; i< count; i++){
      list.add(Result.fromMapObject(gameMapList[i]));
    }
    return list;
  }

  Future<List<Result>> getSingleQueryResult(String slug) async{
    var gameMapList = await getGame(slug);

    int count = gameMapList.length;

    List<Result> list = List<Result>();

    for (int i = 0; i< count; i++){
      list.add(Result.fromMapObject(gameMapList[i]));
    }
    return list;

  }
}
