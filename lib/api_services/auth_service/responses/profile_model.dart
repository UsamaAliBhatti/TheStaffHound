// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.data,
  });

  Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.street,
    this.state,
    this.zipCode,
    this.city,
    this.country,
    this.status,
    this.paymentStatus,
    this.branchIds,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? street;
  String? state;
  String? zipCode;
  String? city;
  String? country;
  String? status;
  dynamic paymentStatus;
  dynamic branchIds;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        street: json["street"] ?? '',
        state: json["state"],
        zipCode: json["zip_code"],
        city: json["city"],
        country: json["country"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        branchIds: json["branch_ids"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "street": street ?? '',
        "state": state,
        "zip_code": zipCode,
        "city": city,
        "country": country,
        "status": status,
        "payment_status": paymentStatus,
        "branch_ids": branchIds,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
