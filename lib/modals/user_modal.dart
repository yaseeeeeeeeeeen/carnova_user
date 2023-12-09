import 'dart:convert';

UserModal welcomeFromJson(String str) {
  final jsonData = json.decode(str);
  return UserModal.fromJson(jsonData);
}

String welcomeToJson(UserModal data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class UserModal {
  String id;
  String name;
  String email;
  int phone;

  String? profile;
  bool isBlocked;

  UserModal({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profile,
    required this.isBlocked,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        profile: json["profile"]??"",
        isBlocked: json["isBlocked"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "profile": profile,
        "isBlocked": isBlocked,
        "_id": id
      };
}

UserModal? logedUser;

