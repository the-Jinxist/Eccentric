import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_app/domain/models/DatabaseModel.dart';
import 'package:game_app/domain/models/GamesModel.dart';

class DatabaseRepo{

  static Firestore _dbInstance;

  static Firestore _getDbInstance(){
    if(_dbInstance != null){
      return _dbInstance;
    }else{
      _dbInstance = Firestore.instance;
      return _dbInstance;
    }
  }

  static Future<void> storeSavedGames({String userID, List<Map<String, dynamic>> savedGames}) async{
    var finalMap = Map<String, dynamic>();
    finalMap["savedGames"] = savedGames;
    return _getDbInstance().collection("Users").document(userID).setData(finalMap);
  }

  static Future<List<Result>> getStoredSavedGames({String userID}) async{
    var documentSnapshot = await _getDbInstance().collection("Users").document(userID).get();
    List<Result> results = [];

    if(documentSnapshot != null){
      List<Map<String, dynamic>> values = documentSnapshot["savedGames"];
      for(Map<String, dynamic> value in values){
        var result = Result.fromMapObject(value);
        results.add(result);
      }
    }


    return results;
  }

  static Future<List<dynamic>> saveCloudGamesToDB({String userID}) async {
    var games = await getStoredSavedGames(userID: userID);
    if (games.isEmpty){
      return await DatabaseHelper().insertGames(games);
    }

    return null;
  }

}