// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.message,
    this.token,
    this.data,
    this.address,
    this.phone,
  });

  String? message;
  String? token;
  Data? data;
  String? address;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "data": data!.toJson(),
        "address": address,
        "phone": phone,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.deviceToken,
    this.code,
    this.unavailability,
    this.unavailabilityFrom,
    this.unavailabilityTo,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic deviceToken;
  dynamic code;
  int? unavailability;
  String? unavailabilityFrom;
  String? unavailabilityTo;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        deviceToken: json["device_token"],
        code: json["code"],
        unavailability: json["availability"],
        unavailabilityFrom: json["unavailability_from"],
        unavailabilityTo: json["unavailability_to"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "device_token": deviceToken,
        "code": code,
        "availability": unavailability,
        "unavailability_from": unavailabilityFrom,
        "unavailability_to": unavailabilityTo,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
