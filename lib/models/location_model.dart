import 'package:nul_app/models/tag_model.dart';

class Location {
  int? id;
  String? name;
  String? imageUrl;
  double? rating;
  List<Tag>? tags;
  String? desc;
  bool? isFavorite;

  Location({this.id, this.name, this.imageUrl, this.rating, this.tags , this.desc , this.isFavorite});

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
      desc: json['desc'],
      isFavorite: json['is_favorite']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'rating': rating,
      'tags': tags?.map((tag) => tag.toJson()).toList(),
      'desc':desc , 
      'is_favorite' : isFavorite
    };
  }
}
