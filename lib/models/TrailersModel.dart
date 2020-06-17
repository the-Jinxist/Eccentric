
class TrailersModel{

  final int id;
  final String name;
  final String preview;
  final Object data;


  TrailersModel(this.id, this.name, this.preview, this.data);

  factory TrailersModel.fromJson(Map<String, dynamic> json){
    int id = json['id'] as int;
    String name = json['name'] as String;
    String preview = json['preview'] as String;
    Object data = json['data'] as Object;

    return TrailersModel(id, name, preview, data);
  }

}