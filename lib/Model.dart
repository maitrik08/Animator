class Model {
  String position = '';
  String name = '';
  String image = '';
  String velocity = '';
  String distance = '';
  String description = '';

  Model(
      { required this.position,
        required this.name,
        required this.image,
        required this.velocity,
        required this.distance,
        required this.description});

  Model.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    name = json['name'];
    image = json['image'];
    velocity = json['velocity'];
    distance = json['distance'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['name'] = this.name;
    data['image'] = this.image;
    data['velocity'] = this.velocity;
    data['distance'] = this.distance;
    data['description'] = this.description;
    return data;
  }
  static List<Model> parselist(List value) {
    List<Model> listdata = value.map((e) => Model.fromJson(e)).toList();
    return listdata;
  }
}