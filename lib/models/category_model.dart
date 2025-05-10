import 'location_model.dart';

class Category {
  int? id;
  String? name;
  String? icon;
  List<Location>? locations;

  Category({this.id, this.name, this.icon, this.locations});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];

    // Parse locations array
    if (json['locations'] != null) {
      locations = List<Location>.from(
        json['locations'].map((location) => Location.fromJson(location)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;

    if (locations != null) {
      data['locations'] =
          locations!.map((location) => location.toJson()).toList();
    }

    return data;
  }

  static List<Category> fromJsonList(List list) {
    if (list.isEmpty) return List<Category>.empty();
    return list.map((item) => Category.fromJson(item)).toList();
  }
}
