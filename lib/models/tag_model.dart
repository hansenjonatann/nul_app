class Tag {
  int? id;
  String? name;
  String? slug;

  Tag({this.id, this.name, this.slug});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }

  static List<Tag> fromJsonList(List list) {
    if (list.length == 0) return List<Tag>.empty();
    return list.map((item) => Tag.fromJson(item)).toList();
  }
}
