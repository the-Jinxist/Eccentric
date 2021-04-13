
class GenreModel{

  final int count;
  final String next;
  final String previous;
  final List<GenreResult> results;

  GenreModel(this.count, this.next, this.previous, this.results);

  factory GenreModel.fromJson(Map<String, dynamic> json){

    List<GenreResult> results = [];

    int count = json['count'] as int;
    String next = json['next'] as String;
    String previous = json['previous'] as String;

    var resultList = json['results'] as List<dynamic>;
    for(json in resultList){
      int id = json['id'] as int;
      String name = json['name'] as String;
      String slug = json['slug'] as String;
      int gamesCount = json['games_count'] as int;
      String imageBackground = json['image_background'] as String;

      var result = GenreResult(id, name, slug, gamesCount, imageBackground);
      results.add(result);
    }

    return GenreModel(count, next, previous, results);
  }

}

class GenreResult{

  final int id;
  final String name;
  final String slug;
  final int gameCount;
  final String imageBackground;

  GenreResult(this.id, this.name, this.slug, this.gameCount, this.imageBackground);

}