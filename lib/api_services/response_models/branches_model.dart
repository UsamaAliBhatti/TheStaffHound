// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BranchesModel branchesFromJson(String str) =>
    BranchesModel.fromJson(json.decode(str));

String branchesToJson(BranchesModel data) => json.encode(data.toJson());

class BranchesModel {
  BranchesModel({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
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
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
