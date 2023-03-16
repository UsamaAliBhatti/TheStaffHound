// To parse this JSON data, do
//
//     final saveProjectResponse = saveProjectResponseFromJson(jsonString);

import 'dart:convert';

SaveProjectResponse saveProjectResponseFromJson(String str) => SaveProjectResponse.fromJson(json.decode(str));

String saveProjectResponseToJson(SaveProjectResponse data) => json.encode(data.toJson());

class SaveProjectResponse {
    SaveProjectResponse({
        required this.success,
    });

    Success success;

    factory SaveProjectResponse.fromJson(Map<String, dynamic> json) => SaveProjectResponse(
        success: Success.fromJson(json["success"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success.toJson(),
    };
}

class Success {
    Success({
        required this.projectId,
        required this.status,
        required this.jobseekerId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    String projectId;
    String status;
    int jobseekerId;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        projectId: json["project_id"],
        status: json["status"],
        jobseekerId: json["jobseeker_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "status": status,
        "jobseeker_id": jobseekerId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
