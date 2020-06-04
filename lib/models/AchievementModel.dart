
class AchievementModel{

  final int id;
  final String name;
  final String description;
  final String image;
  final String percent;

  AchievementModel(
      this.id,
      this.name,
      this.description,
      this.image,
      this.percent
      );

  factory AchievementModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] as int;
    String name = json['name'] as String;
    String description = json['description'] as String;
    String image = json['image'] as String;
    String percent = json['percent'] as String;

    return AchievementModel(id, name, description, image, percent);
  }

}