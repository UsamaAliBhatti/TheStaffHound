// To parse this JSON data, do
//
//     final savedJobsResponse = savedJobsResponseFromJson(jsonString);

import 'dart:convert';

SavedJobsResponse savedJobsResponseFromJson(String str) => SavedJobsResponse.fromJson(json.decode(str));

String savedJobsResponseToJson(SavedJobsResponse data) => json.encode(data.toJson());

class SavedJobsResponse {
    SavedJobsResponse({
        required this.success,
    });

    List<Success> success;

    factory SavedJobsResponse.fromJson(Map<String, dynamic> json) => SavedJobsResponse(
        success: List<Success>.from(json["success"].map((x) => Success.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x.toJson())),
    };
}

class Success {
    Success({
        required this.id,
        required this.jobseekerId,
        required this.projectId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.clientId,
        required this.title,
        this.description,
        required this.rateHour,
        required this.branch,
        required this.required,
        this.selected,
        this.requiredAt,
        this.responsibilities,
        this.workingHours,
        this.hiringType,
    });

    int id;
    int jobseekerId;
    String projectId;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String clientId;
    String title;
    dynamic description;
    String rateHour;
    String branch;
    int required;
    dynamic selected;
    dynamic requiredAt;
    dynamic responsibilities;
    dynamic workingHours;
    dynamic hiringType;

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        jobseekerId: json["jobseeker_id"],
        projectId: json["project_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        clientId: json["client_id"],
        title: json["title"],
        description: json["description"],
        rateHour: json["rate_hour"],
        branch: json["branch"],
        required: json["required"],
        selected: json["selected"],
        requiredAt: json["required_at"],
        responsibilities: json["responsibilities"],
        workingHours: json["working_hours"],
        hiringType: json["hiring_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jobseeker_id": jobseekerId,
        "project_id": projectId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "client_id": clientId,
        "title": title,
        "description": description,
        "rate_hour": rateHour,
        "branch": branch,
        "required": required,
        "selected": selected,
        "required_at": requiredAt,
        "responsibilities": responsibilities,
        "working_hours": workingHours,
        "hiring_type": hiringType,
    };
}
