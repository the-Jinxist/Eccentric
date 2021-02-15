import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:game_app/datasources/api/api_utils.dart';
import 'package:game_app/datasources/repo/z_repo.dart';
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
      GENRE_ENDPOINT,
      headers: _userAgentHeader,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GenreModel gameModel = GenreModel.fromJson(json.decode(response.body));
      return gameModel;
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  } catch (e) {
    throw Exception("$e");
  }
}

Future<GamesModel> getYourGamesService() async {
  try {
    String genreString = await getGenreString();

    Response response = await get(
        GAMES_ENDPOINT + '?genres=$genreString&page=1',
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

Future<Response> getGamesFromDevelopers(String developers) async {
  return get("https://api.rawg.io/api/games?developers=$developers&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GamesModel> getYourGamesFromDevelopersService(
    {String developers}) async {
  try {
    Response response = await get(
        GAMES_ENDPOINT + '?developers=$developers&page=1',
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

Future<Response> getGamesFromPublishers(String publishers) async {
  return get("https://api.rawg.io/api/games?publishers=$publishers&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GamesModel> getYourGamesFromPublishersService(
    {String publishers}) async {
  try {
    Response response = await get(
        GAMES_ENDPOINT + '?publishers=$publishers&page=1',
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

Future<Response> getGamesFromPlatform(String platforms) async {
  return get("https://api.rawg.io/api/games?platforms=$platforms&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GamesModel> getYourGamesFromPlatformService({String platform}) async {
  try {
    Response response = await get(
        GAMES_ENDPOINT + '?platforms=$platform&page=1',
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

Future<Response> getGamesFromSearch(String query) async {
  return get("https://api.rawg.io/api/games?search=$query&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GamesModel> getYourGamesFromSearchService({String query}) async {
  try {
    Response response = await get(GAMES_ENDPOINT + '?search=$query&page=1',
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

Future<Response> getGameDetail(int id) async {
  return get("https://api.rawg.io/api/games/$id",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GameDetailModel> getGameDetailsService({int id}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$id",
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

Future<Response> getGameScreenshots(String slug) async {
  return get("https://api.rawg.io/api/games/$slug/screenshots",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<ScreenshotsModel> getGameScreenshotsService({String slug}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$slug/screenshots",
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

Future<Response> getGameTrailer(String slug) async {
  return get("https://api.rawg.io/api/games/$slug/movies",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<TrailersModel> getGameTrailersService({String slug}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$slug/movies",
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

Future<Response> getGameAchievement(int id) async {
  return get("https://api.rawg.io/api/games/$id/achievements",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<AchievementModel> getGameAchievementsService({int id}) async {
  try {
    Response response = await get(
      GAMES_ENDPOINT + "/$id/achievements",
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

Future<Response> getPlatforms() async {
  return get("https://api.rawg.io/api/platforms?ordering=year_start&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<PlatformModel> getPlatformsService() async {
  try {
    Response response = await get(
      PLATFORMS_ENDPOINT,
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

Future<Response> getPublishers() async {
  return get("https://api.rawg.io/api/publishers",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<PublishersModel> getPublishersService() async {
  try {
    Response response = await get(
      PUBLISHERS_ENDPOINT,
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

Future<Response> getPopular() async {
  return get(
      "https://api.rawg.io/api/games?dates=${getPastYear()}-06-01,${getCurrentYear()}-06-01&ordering=-added&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GamesModel> getPopularService() async {
  try {
    Response response = await get(
      GAMES_ENDPOINT +
          "?dates=${getPastYear()}-06-01,${getCurrentYear()}-06-01&ordering=-added&page=1",
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

Future<Response> getAnticipated() async {
  return get(
      "https://api.rawg.io/api/games?dates=${getCurrentYear()}-06-01,${getNextYear()}-06-01&ordering=-added&page=1",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<GamesModel> getAnticipatedService() async {
  try {
    Response response = await get(
      GAMES_ENDPOINT +
          "?dates=${getCurrentYear()}-06-01,${getNextYear()}-06-01&ordering=-added&page=1",
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

Future<Response> getDevelopers() async {
  return get("https://api.rawg.io/api/developers",
      headers: {HttpHeaders.userAgentHeader: "Eccentric Catalog"});
}

Future<PublishersModel> getDevelopersService() async {
  try {
    Response response = await get(
      DEVELOPERS_ENDPOINT,
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

//Game id: 36755
