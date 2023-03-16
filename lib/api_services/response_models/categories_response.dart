// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
    CategoriesResponse({
        required this.success,
    });

    List<Success> success;

    factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        success: List<Success>.from(json["success"].map((x) => Success.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x.toJson())),
    };
}

class Success {
    Success({
        required this.id,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String title;
    DateTime createdAt;
    DateTime updatedAt;

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
