import 'dart:async';

import 'package:http/http.dart' as http;

Future<http.Response> getGenres() async{
  return http.get("https://api.rawg.io/api/genres");
}

Future<http.Response> getGames(String genreString) async{
  return http.get("https://api.rawg.io/api/games?genres=$genreString");
}

Future<http.Response> getGameDetail(int id) async{
  return http.get("https://api.rawg.io/api/games/$id");
}

Future<http.Response> getPlatforms() async{
  return http.get("https://api.rawg.io/api/platforms?ordering=year_start");
}

Future<http.Response> getPublishers() async{
  return http.get("https://api.rawg.io/api/publishers");
}

Future<http.Response> getPopular() async{
  return http.get("https://api.rawg.io/api/games?dates=2019-06-01,2020-06-01&ordering=-added");
}

Future<http.Response> getAnticipated() async{
  return http.get("https://api.rawg.io/api/games?dates=2020-06-01,2021-06-01&ordering=-added");
}

Future<http.Response> getDevelopers() async{
  return http.get("https://api.rawg.io/api/developers");
}

//Game id: 36755

