// To parse this JSON data, do
//
//     final applyJobResponse = applyJobResponseFromJson(jsonString);

import 'dart:convert';

ApplyJobResponse applyJobResponseFromJson(String str) => ApplyJobResponse.fromJson(json.decode(str));

String applyJobResponseToJson(ApplyJobResponse data) => json.encode(data.toJson());

class ApplyJobResponse {
    ApplyJobResponse({
        required this.success,
    });

    Success success;

    factory ApplyJobResponse.fromJson(Map<String, dynamic> json) => ApplyJobResponse(
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
