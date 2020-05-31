
class GameModel{

  final int count;
  final String next;
  final String previous;
  final List<Result> results;

  GameModel(this.count, this.next, this.previous, this.results);

  factory GameModel.fromJson(Map<String, dynamic> json){

    List<Result> results = [];

    int count = json['count'] as int;
    String next = json['next'] as String;
    String previous = json['previous'] as String;

    var resultList = json['results'] as List<dynamic>;
    for(json in resultList){
      int id = json['id'] as int;
      String name = json['name'] as String;
      String slug = json['slug'] as String;
      String released = json['released'] as String;
      bool tba = json['tba'] as bool;
      String backgroundImage = json['background_image'] as String;
      int rating = json['rating'] as int;
      int ratingTop = json['rating_top'] as int;
      Object ratings = json['ratings'] as Object;
      int ratingsCount = json['ratings_count'] as int;
      String reviewsTextCount = json['reviews_text_count'] as String;
      int added = json['added'] as int;
      Object addedByStatus = json['added_by_status'] as Object;
      int metacritic = json['metacritic'] as int;
      int playtime = json['playtime'] as int;
      int suggestionsCount = json['suggestions_count'] as int;



      var result = Result(id: id, name: name, slug: slug, released: released,
      tba: tba, added: added, addedByStatus: addedByStatus, backgroundImage: backgroundImage,
      metacritic: metacritic, playtime: playtime, rating: rating, ratings: ratings,
      ratingsCount: ratingsCount, ratingsTop: ratingTop, reviewsTextCount: reviewsTextCount,
      suggestionsCount: suggestionsCount);
      results.add(result);
    }

    return GameModel(count, next, previous, results);
  }

}

class Result{

  final int id;
  final String slug;
  final String name;
  final String released;
  final bool tba;
  final String backgroundImage;
  final int rating;
  final int ratingsTop;
  final Object ratings;
  final int ratingsCount;
  final String reviewsTextCount;
  final int added;
  final Object addedByStatus;
  final int metacritic;
  final int playtime;
  final int suggestionsCount;

  Result({this.id, this.slug, this.name,
    this.released, this.tba, this.backgroundImage, this.rating, this.ratingsTop,
    this.ratings, this.ratingsCount, this.reviewsTextCount, this.added,
    this.addedByStatus, this.metacritic, this.playtime, this.suggestionsCount});

}