import 'package:nul_app/models/location_model.dart';

class Favorite {
  int? id;
  int? locationId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Location? location;

  Favorite({
    this.id,
    this.locationId,
    this.userId,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json['id'],
        locationId: json['location_id'],
        userId: json['user_id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        deletedAt: json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'])
            : null,
        location: Location.fromJson(json['location']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location_id': locationId,
      'user_id': userId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'location': location
    };
  }
}
