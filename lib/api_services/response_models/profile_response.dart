// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.profile,
    this.address,
  });

  Profile? profile;
  String? address;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        profile: Profile.fromJson(json["profile"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile!.toJson(),
        "address": address,
      };
}

class Profile {
  Profile({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.street1,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.description,
    this.access,
    this.access1,
    this.status,
    this.paymentStatus,
    this.totalBranch,
    this.userId,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });


  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? street1;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? description;
  String? access;
  String? access1;
  String? status;
  String? paymentStatus;
  String? totalBranch;
  String? userId;
  String? branchId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"] ?? '',
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        street1: json["street1"] ?? '',
        city: json["city"],
        state: json["state"] ?? '',
        zipCode: json["zip_code"] ?? '',
        country: json["country"] ?? '',
        description: json["description"],
        access: json["access"],
        access1: json["access1"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        totalBranch: json["total_branch"],
        userId: json["user_id"],
        branchId: json["branch_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "street1": street1,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "country": country,
        "description": description,
        "access": access,
        "access1": access1,
        "status": status,
        "payment_status": paymentStatus,
        "total_branch": totalBranch,
        "user_id": userId,
        "branch_id": branchId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
