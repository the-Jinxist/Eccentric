import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:game_app/datasources/api/api_utils.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:http/http.dart';

int getCurrentYear(){
  print("Rawg Api: ${DateTime.now().year}");
  return DateTime.now().year;
}

int getPastYear(){
  print("Rawg Api: ${DateTime.now().year -1}");
  return DateTime.now().year - 1;
}

int getNextYear(){
  print("Rawg Api: ${DateTime.now().year + 1}");
  return DateTime.now().year + 1;
}

Map<String, String> _userAgentHeader = {HttpHeaders.userAgentHeader : "Eccentric Catalog"};

Future<Response> getGenres() async {
  return get("https://api.rawg.io/api/genres",
    headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"},
  );
}

Future<GamesModel> getAnticipatedService() async {

  try{

    Response response =
      await get(
        GAMES_ENDPOINT + "?dates=${getCurrentYear()}-06-01,${getNextYear()}-06-01&ordering=-added&page=1",
        headers: _userAgentHeader,
      );

    if(response.statusCode == 200 || response.statusCode == 201){

      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;

    }else{
      throw Exception("${response.statusCode}, ${response.body}");
    }

  }catch(e){
    throw Exception("$e");
  }

}

Future<Response> getGames(String genreString) async{
  return get("https://api.rawg.io/api/games?genres=$genreString&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGamesFromDevelopers(String developers) async{
  return get("https://api.rawg.io/api/games?developers=$developers&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGamesFromPublishers(String publishers) async{
  return get("https://api.rawg.io/api/games?publishers=$publishers&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGamesFromPlatform(String platforms) async{
  return get("https://api.rawg.io/api/games?platforms=$platforms&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGamesFromSearch(String query) async{
  return get("https://api.rawg.io/api/games?search=$query&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGameDetail(int id) async{
  return get("https://api.rawg.io/api/games/$id",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGameScreenshots(String slug) async{
  return get("https://api.rawg.io/api/games/$slug/screenshots",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGameTrailer(String slug) async{
  return get("https://api.rawg.io/api/games/$slug/movies",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getGameAchievement(int id) async{
  return get("https://api.rawg.io/api/games/$id/achievements",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getPlatforms() async{
  return get("https://api.rawg.io/api/platforms?ordering=year_start&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getPublishers() async{
  return get("https://api.rawg.io/api/publishers",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getPopular() async{
  return get("https://api.rawg.io/api/games?dates=${getPastYear()}-06-01,${getCurrentYear()}-06-01&ordering=-added&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getAnticipated() async{
  return get("https://api.rawg.io/api/games?dates=${getCurrentYear()}-06-01,${getNextYear()}-06-01&ordering=-added&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<Response> getDevelopers() async{
  return get("https://api.rawg.io/api/developers",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

//Game id: 36755

