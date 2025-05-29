import 'dart:convert';

class User {
  String name;
  String email;
  String address;
  String profileImage;

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'profileImage': profileImage,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  static User fromJson(String jsonString) {
    return fromMap(jsonDecode(jsonString));
  }
}
