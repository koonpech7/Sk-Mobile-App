// To parse this JSON data, do
//
//     final getMelogin = getMeloginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetMelogin getMeloginFromJson(String str) =>
    GetMelogin.fromJson(json.decode(str));

String getMeloginToJson(GetMelogin data) => json.encode(data.toJson());

class GetMelogin {
  GetMelogin({
    required this.id,
    required this.active,
    required this.firstName,
    required this.lastName,
    required this.tel,
    required this.password,
    required this.email,
  });

  final int id;
  final bool active;
  final String firstName;
  final String lastName;
  final String tel;
  final String password;
  final String email;

  factory GetMelogin.fromJson(Map<String, dynamic> json) => GetMelogin(
        id: json["id"],
        active: json["active"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        tel: json["tel"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "first_name": firstName,
        "last_name": lastName,
        "tel": tel,
        "password": password,
        "email": email,
      };
}
