class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? country;
  String? pictureUrl;
  String? dob;
  String? role;

  User(
      {this.id,
      this.email,
      this.phone,
      this.role,
      this.name,
      this.pictureUrl,
      this.country,
      this.dob,
      this.gender});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phoneNumber'],
        role: json['role'],
        country: json['country'],
        dob: json['dob'],
        gender: json['gender'],
        pictureUrl: json['pictureUrl']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['role'] = role;
    data['dob'] = dob;
    data['phoneNumber'] = phone;
    data['country'] = country;
    data['pictureUrl'] = pictureUrl;
    return data;
  }

  static List<User> fromJsonList(List list) {
    if (list.length == 0) return List<User>.empty();
    return list.map((item) => User.fromJson(item)).toList();
  }
}
