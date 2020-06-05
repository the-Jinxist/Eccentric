import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<http.Response> getGenres() async{
  return http.get("https://api.rawg.io/api/genres",
    headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"},
  );
}

Future<http.Response> getGames(String genreString) async{
  return http.get("https://api.rawg.io/api/games?genres=$genreString&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGamesFromDevelopers(String developers) async{
  return http.get("https://api.rawg.io/api/games?developers=$developers&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGamesFromPublishers(String publishers) async{
  return http.get("https://api.rawg.io/api/games?publishers=$publishers&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGamesFromPlatform(String platforms) async{
  return http.get("https://api.rawg.io/api/games?platforms=$platforms&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGameDetail(int id) async{
  return http.get("https://api.rawg.io/api/games/$id",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGameScreenshots(String slug) async{
  return http.get("https://api.rawg.io/api/games/$slug/screenshots",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGameTrailer(String slug) async{
  return http.get("https://api.rawg.io/api/games/$slug/movies",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getGameAchievement(int id) async{
  return http.get("https://api.rawg.io/api/games/$id/achievements",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getPlatforms() async{
  return http.get("https://api.rawg.io/api/platforms?ordering=year_start&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getPublishers() async{
  return http.get("https://api.rawg.io/api/publishers",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getPopular() async{
  return http.get("https://api.rawg.io/api/games?dates=2019-06-01,2020-06-01&ordering=-added&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getAnticipated() async{
  return http.get("https://api.rawg.io/api/games?dates=2020-06-01,2021-06-01&ordering=-added&page=1",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

Future<http.Response> getDevelopers() async{
  return http.get("https://api.rawg.io/api/developers",
      headers: {HttpHeaders.userAgentHeader : "Eccentric Catalog"});
}

//Game id: 36755

