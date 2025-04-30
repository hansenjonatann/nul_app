class Location {
  int? id;
  String? name;
  String? imageUrl;
  double? rating;

  Location({this.id, this.name, this.imageUrl, this.rating});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['rating'] = rating;
    return data;
  }

  static List<Location> fromJsonList(List list) {
    if (list.length == 0) return List<Location>.empty();
    return list.map((item) => Location.fromJson(item)).toList();
  }
}
