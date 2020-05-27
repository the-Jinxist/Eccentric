import 'dart:async';

import 'package:http/http.dart' as http;

Future<http.Response> getGenres() async{
  return http.get("https://api.rawg.io/api/genres");
}

Future<http.Response> getGamesFromGenres(String genres) async{
return http.get("https://api.rawg.io/api/genres");
}