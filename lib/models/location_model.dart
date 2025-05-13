import 'package:nul_app/models/tag_model.dart';

class Location {
  int? id;
  String? name;
  String? imageUrl;
  double? rating;
  List<Tag>? tags;

  Location({this.id, this.name, this.imageUrl, this.rating, this.tags});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      rating: (json['rating'] as num).toDouble(),
      tags: json['tags'] != null
          ? (json['tags'] as List<dynamic>)
              .map((tagJson) => Tag.fromJson(tagJson))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'rating': rating,
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }
}
