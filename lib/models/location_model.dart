import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/models/tag_model.dart';

class Location {
  int? id;
  String? name;
  String? imageUrl;
  double? rating;
  String? desc;
  bool? isFavorite;
  List<Tag>? tags;
  double? rateCount;

  Location(
      {this.id,
      this.name,
      this.desc,
      this.isFavorite,
      this.imageUrl,
      this.rating,
      this.tags,
      this.rateCount});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        name: json['name'],
        desc: json['desc'],
        isFavorite: json['is_favorite'],
        imageUrl: json['image_url'],
        rating: (json['rating'] as num).toDouble(),
        tags: json['tags'] != null
            ? (json['tags'] as List<dynamic>)
                .map((tagJson) => Tag.fromJson(tagJson))
                .toList()
            : [],
        rateCount: json['rate_count']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'rating': rating,
      'tags': tags?.map((tag) => tag.toJson()).toList(),
      'rate_count': rateCount,
      'is_favorite': isFavorite,
      'desc': desc
    };
  }
}
