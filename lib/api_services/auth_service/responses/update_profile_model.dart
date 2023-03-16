// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
    UpdateProfileModel({
        this.name,
        this.street,
        this.state,
        this.zipCode,
        this.city,
        this.country,
    });

    String? name;
    String? street;
    String? state;
    String? zipCode;
    String? city;
    String? country;

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
        name: json["name"],
        street: json["street"],
        state: json["state"],
        zipCode: json["zip_code"],
        city: json["city"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "street": street,
        "state": state,
        "zip_code": zipCode,
        "city": city,
        "country": country,
    };
}
