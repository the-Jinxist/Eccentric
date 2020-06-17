
class GameDetailModel{

  //The only needed info
  final String description;
  final String updated;
  final String backgroundImageAdditional;
  final String website;
  final String redditUrl;
  final int creatorsCount;

  GameDetailModel(
      this.description,
      this.updated,
      this.backgroundImageAdditional,
      this.website,
      this.redditUrl,
      this.creatorsCount
      );

  factory GameDetailModel.fromJson(Map<String, dynamic> json){

    String description = json['description'] as String;
    String updated = json['updated'] as String;
    String backgroundImageAdditional = json['background_image_additional'] as String;
    String website = json['website'] as String;
    String redditUrl = json['reddit_url'] as String;
    int creatorsCount = json['creators_count'] as int;

    return GameDetailModel(
        description,
        updated,
        backgroundImageAdditional,
        website,
        redditUrl,
        creatorsCount);
  }

}