import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:http/http.dart';

int getCurrentYear() {
  print("Rawg Api: ${DateTime.now().year}");
  return DateTime.now().year;
}

int getPastYear() {
  print("Rawg Api: ${DateTime.now().year - 1}");
  return DateTime.now().year - 1;
}

int getNextYear() {
  print("Rawg Api: ${DateTime.now().year + 1}");
  return DateTime.now().year + 1;
}

Map<String, String> _userAgentHeader = {
  HttpHeaders.userAgentHeader: "Eccentric Catalog"
};

Future<GenreModel> getGenresService() async {
  try {
    Response response = await get(
      GENRE_ENDPOINT + '?key=$API_KEY',
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GenreModel gameModel = GenreModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      print("Gnnre Exception: ${response.statusCode}, ${response.body}");
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    print("Gnnre Exception: $e");
    throw Exception("$e");
  }
}

Future<GamesModel> getYourGamesService() async {
  try {
    String genreString = await getGenreString();

    Response response = await get(
        GAMES_ENDPOINT + '?key=$API_KEY&genres=$genreString&page=1',
        headers: _userAgentHeader);

    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<GamesModel> getYourGamesFromDevelopersService(
    {String developers}) async {
  try {
    Response response = await get(
        GAMES_ENDPOINT + '?key=$API_KEY&developers=$developers&page=1',
        headers: _userAgentHeader);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<GamesModel> getYourGamesFromPublishersService(
    {String publishers}) async {
  try {
    Response response = await get(
        GAMES_ENDPOINT + '?key=$API_KEY&publishers=$publishers&page=1',
        headers: _userAgentHeader);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<GamesModel> getYourGamesFromPlatformService({String platform}) async {
  try {
    Response response = await get(
        GAMES_ENDPOINT + '?key=$API_KEY&platforms=$platform&page=1',
        headers: _userAgentHeader);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<GamesModel> getYourGamesFromSearchService({String query}) async {
  try {
    Response response = await get(GAMES_ENDPOINT + '?key=$API_KEY&search=$query&page=1',
        headers: _userAgentHeader);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<GameDetailModel> getGameDetailsService({int id}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$id?key=$API_KEY",
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GameDetailModel gameModel =
          GameDetailModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<ScreenshotsModel> getGameScreenshotsService({String slug}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$slug/screenshots?key=$API_KEY",
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScreenshotsModel gameModel =
          ScreenshotsModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<TrailersModel> getGameTrailersService({String slug}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$slug/movies?key=$API_KEY",
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      TrailersModel gameModel =
          TrailersModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<AchievementModel> getGameAchievementsService({int id}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$id/achievements?key=$API_KEY",
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      AchievementModel gameModel =
          AchievementModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<PlatformModel> getPlatformsService() async {
  try {
    Response response = await get(
      PLATFORMS_ENDPOINT + '?key=$API_KEY',
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      PlatformModel gameModel =
          PlatformModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<PublishersModel> getPublishersService() async {
  try {
    Response response = await get(
      PUBLISHERS_ENDPOINT + '?key=$API_KEY',
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      PublishersModel gameModel =
          PublishersModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<GamesModel> getPopularService() async {
  try {
    Response response = await get(
      GAMES_ENDPOINT +
          "?key=$API_KEY&dates=${getPastYear()}-06-01,${getCurrentYear()}-06-01&ordering=-added&page=1",
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<GamesModel> getAnticipatedService() async {
  try {
    Response response = await get(
      GAMES_ENDPOINT +
          "?key=$API_KEY&dates=${getCurrentYear()}-06-01,${getNextYear()}-06-01&ordering=-added&page=1",
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GamesModel gameModel = GamesModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}


Future<PublishersModel> getDevelopersService() async {
  try {
    Response response = await get(
      DEVELOPERS_ENDPOINT + '?key=$API_KEY',
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      PublishersModel gameModel =
          PublishersModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

//Game id: 36755 FOR TESTING
