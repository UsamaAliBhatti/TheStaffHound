// To parse this JSON data, do
//
//     final branchesResponse = branchesResponseFromJson(jsonString);

import 'dart:convert';

BranchesResponse branchesResponseFromJson(String str) => BranchesResponse.fromJson(json.decode(str));

String branchesResponseToJson(BranchesResponse data) => json.encode(data.toJson());

class BranchesResponse {
    BranchesResponse({
        this.message,
        this.data,
    });

    String? message;
    List<Datum>? data;

    factory BranchesResponse.fromJson(Map<String, dynamic> json) => BranchesResponse(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.userId,
        this.agencyId,
        this.name,
        this.email,
        this.phone,
        this.street,
        this.state,
        this.zipCode,
        this.country,
        this.description,
        this.status,
        this.paymentStatus,
        this.licenseNum,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? userId;
    int? agencyId;
    String? name;
    String? email;
    String? phone;
    String? street;
    String? state;
    String? zipCode;
    String? country;
    String? description;
    String? status;
    String? paymentStatus;
    String? licenseNum;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        agencyId: json["agency_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        street: json["street"],
        state: json["state"],
        zipCode: json["zip_code"],
        country: json["country"],
        description: json["description"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        licenseNum: json["license_num"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "agency_id": agencyId,
        "name": name,
        "email": email,
        "phone": phone,
        "street": street,
        "state": state,
        "zip_code": zipCode,
        "country": country,
        "description": description,
        "status": status,
        "payment_status": paymentStatus,
        "license_num": licenseNum,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
