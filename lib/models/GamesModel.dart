
class GamesModel{

  final int count;
  final String next;
  final String previous;
  final List<Result> results;

  GamesModel(this.count, this.next, this.previous, this.results);

  factory GamesModel.fromJson(Map<String, dynamic> json){

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
      double rating = json['rating'] as double;
      int ratingTop = json['rating_top'] as int;
      Object ratings = json['ratings'] as Object;
      int ratingsCount = json['ratings_count'] as int;
      int reviewsTextCount = json['reviews_text_count'] as int;
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

    return GamesModel(count, next, previous, results);
  }

}

class Result{

  int id;
  String slug;
  String name;
  String released;
  bool tba;
  String backgroundImage;
  double rating;
  int ratingsTop;
  Object ratings;
  int ratingsCount;
  int reviewsTextCount;
  int added;
  Object addedByStatus;
  int metacritic;
  int playtime;
  int suggestionsCount;



  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['slug'] = slug;
    map ['name'] = name;
    map ['released'] = released;
    map ['tba'] = tba;
    map ['backgroundImage'] = backgroundImage;
    map ['rating'] = rating;
    map ['ratingsTop'] = ratingsTop;
    map ['ratings'] = ratings.toString();
    map ['ratingsCount'] = ratingsCount;
    map ['reviewsTextCount'] = reviewsTextCount;
    map ['added'] = added;
    map ['addedByStatus'] = addedByStatus.toString();
    map ['metacritic'] = metacritic;
    map ['playtime'] = playtime;
    map ['suggestionsCount'] = suggestionsCount;
    return map;
  }

  Result.fromMapObject(Map<String, dynamic> map){
    this.id = map['id'];
    this.slug = map['slug'];
    this.name = map['name'];
    this.added = map['added'];
    this.addedByStatus = map['addedByStatus'];
    this.backgroundImage = map['backgroundImage'];
    this.metacritic = map['metacritic'];
    this.rating = map['rating'];
    this.ratings = map['ratings'];
    this.ratingsCount = map['ratingsCount'];
    this.ratingsTop = map['ratingsTop'];
    this.released = map['released'];
    this.playtime = map['playtime'];
    this.reviewsTextCount = map['reviewsTextCount'];
    this.suggestionsCount = map['suggestionsCount'];
    this.tba = map['tba'];
  }

  Result({this.id, this.slug, this.name,
    this.released, this.tba, this.backgroundImage, this.rating, this.ratingsTop,
    this.ratings, this.ratingsCount, this.reviewsTextCount, this.added,
    this.addedByStatus, this.metacritic, this.playtime, this.suggestionsCount});
}