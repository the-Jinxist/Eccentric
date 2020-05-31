import 'dart:async';

import 'package:http/http.dart' as http;

Future<http.Response> getGenres() async{
  return http.get("https://api.rawg.io/api/genres");
}

Future<http.Response> getGames(String genreString) async{
  return http.get("https://api.rawg.io/api/games?genres=$genreString");
}



