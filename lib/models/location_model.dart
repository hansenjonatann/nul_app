import 'package:nul_app/models/favorite_model.dart';
import 'package:nul_app/models/tag_model.dart';

class Location {
  int? id;
  String? name;
  String? imageUrl;
  double? rating;
  String? desc;
  List<Favorite>? favorites;
  List<Tag>? tags;
  int? rateCount;
  String? address;

  Location(
      {this.id,
      this.name,
      this.desc,
      this.imageUrl,
      this.favorites,
      this.rating,
      this.tags,
      this.address,
      this.rateCount});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      address: json['address'],
      imageUrl: json['image_url'],
      rating:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      tags: json['tags'] != null
          ? (json['tags'] as List<dynamic>)
              .map((tagJson) => Tag.fromJson(tagJson))
              .toList()
          : [],
      rateCount: json['rate_count'],
      favorites: json['favorites'] != null
          ? (json['favorites'] as List<dynamic>)
              .map((favJson) => Favorite.fromJson(favJson))
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
      'rate_count': rateCount,
      'address': address,
      'favorites': favorites?.map((fav) => fav.toJson()).toList(),
      'desc': desc
    };
  }
}
