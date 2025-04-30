class Category {
  int? id;
  String? name;
  String? icon;

  Category({this.id, this.name, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }

  static List<Category> fromJsonList(List list) {
    if (list.length == 0) return List<Category>.empty();
    return list.map((item) => Category.fromJson(item)).toList();
  }
}
