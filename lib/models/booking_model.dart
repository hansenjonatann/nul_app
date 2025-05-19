import 'package:nul_app/models/auth/user_model.dart';
import 'package:nul_app/models/location_model.dart';

class Booking {
  int? id;
  String? bookingCode;
  String? bookingStatus;
  String? bookingTime;
  int? userId;
  int? locationId;
  int? headCount;
  int? tenantId;
  String? dateTime;
  Location? location; // Ubah dari List<Location> menjadi Location?
  User? user;

  Booking({
    this.id,
    this.bookingCode,
    this.bookingStatus,
    this.bookingTime,
    this.userId,
    this.locationId,
    this.headCount,
    this.tenantId,
    this.dateTime,
    this.user,
    this.location,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingCode = json['booking_code'];
    bookingStatus = json['booking_status'];
    bookingTime = json['booking_time'];
    dateTime = json['date_time'];
    userId = json['user_id'];
    tenantId = json['tenant_id'];
    headCount = json['head_count'];
    locationId = json['location_id'];

    // Ambil objek location tunggal
    if (json['location'] != null) {
      location = Location.fromJson(json['location']);
    }

    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['booking_code'] = bookingCode;
    data['booking_time'] = bookingTime;
    data['booking_status'] = bookingStatus;
    data['location_id'] = locationId;
    data['user_id'] = userId;
    data['tenant_id'] = tenantId;
    data['head_count'] = headCount;
    data['date_time'] = dateTime;

    if (location != null) {
      data['location'] = location!.toJson();
    }

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }

  static List<Booking> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => Booking.fromJson(item)).toList();
  }
}
