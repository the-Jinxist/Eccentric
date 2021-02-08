
class PlatformModel{

  final int count;
  final String next;
  final String previous;
  final List<PlatformResult> results;

  PlatformModel(this.count, this.next, this.previous, this.results);

  factory PlatformModel.fromJson(Map<String, dynamic> json){

    List<PlatformResult> results = [];

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
      String image = json['image'] as String;
      int yearStart = json['year_start'] as int;
      int yearEnd = json['year_end'] as int;

      var result = PlatformResult(id, name, slug, gamesCount, imageBackground, image, yearStart, yearEnd);
      results.add(result);
    }

    return PlatformModel(count, next, previous, results);

  }

}

class PlatformResult{

  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String imageBackground;
  final String image;
  final int yearStart;
  final int yearEnd;

  PlatformResult(this.id, this.name, this.slug, this.gamesCount,
      this.imageBackground, this.image, this.yearStart, this.yearEnd);

}
