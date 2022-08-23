// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        this.message,
        this.token,
        this.data,
        this.record,
        this.address,
        this.phone,
    });

    String? message;
    String? token;
    Data? data;
    Data? record;
    String? address;
    String? phone;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
        record: Data.fromJson(json["record"]),
        address: json["address"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "data": data!.toJson(),
        "record": record!.toJson(),
        "address": address,
        "phone": phone,
    };
}

class Data {
    Data({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.emailVerifiedAt,
        this.type,
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? email;
    String? phone;
    String? address;
    String? emailVerifiedAt;
    int? type;
    String? deviceToken;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        emailVerifiedAt: json["email_verified_at"],
        type: json["type"],
        deviceToken: json["device_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "email_verified_at": emailVerifiedAt,
        "type": type,
        "device_token": deviceToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
