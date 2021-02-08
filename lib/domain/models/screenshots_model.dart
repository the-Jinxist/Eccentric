
class ScreenshotsModel{

  final int count;
  final String next;
  final String previous;
  final List<ScreenshotResult> results;

  ScreenshotsModel(this.count, this.next, this.previous, this.results );

  factory ScreenshotsModel.fromJson(Map<String, dynamic> json){

    List<ScreenshotResult> results = [];

    int count = json['count'] as int;
    String next = json['next'] as String;
    String previous = json['previous'] as String;

    var resultList = json['results'] as List<dynamic>;
    for(json in resultList){
      String image = json['image'] as String;
      bool name = json['hidden'] as bool;

      var result = ScreenshotResult(image, name);
      results.add(result);
    }

    return ScreenshotsModel(count, next, previous, results);
  }

}

class ScreenshotResult {
  final String image;
  final bool hidden;

  ScreenshotResult(this.image, this.hidden);
}