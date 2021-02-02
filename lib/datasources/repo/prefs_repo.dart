import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _getInstance(){
  return SharedPreferences.getInstance();
}

Future<String> getGenreString() async{
  var prefs = await _getInstance();
  return prefs.getString("genre");
}

Future<void> setGenreString(String genre) async {
  var prefs = await _getInstance();
  prefs.setString("genre", genre);
}