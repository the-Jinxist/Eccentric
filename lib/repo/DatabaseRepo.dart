import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRepo{

  Firestore _dbInstance;

  Firestore _getDbInstance(){
    if(_dbInstance != null){
      return _dbInstance;
    }else{
      _dbInstance = Firestore.instance;
      return _dbInstance;
    }
  }

  Future<void> storeSavedGames({String userID, List<Map<String, dynamic>> savedGames}) async{
    var finalMap = Map<String, dynamic>();
    finalMap["savedGames"] = savedGames;
    return _getDbInstance().collection("Users").document(userID).setData(finalMap);
  }

}