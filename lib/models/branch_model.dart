// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BranchModel welcomeFromJson(String str) => BranchModel.fromJson(json.decode(str));

String welcomeToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
    BranchModel({
        this.message,
        this.data,
    });

    String? message;
    List<Datum>? data;

    factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
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
        this.name,
    });

    int? id;
    String? name;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
