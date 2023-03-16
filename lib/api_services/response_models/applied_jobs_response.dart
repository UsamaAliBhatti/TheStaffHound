// To parse this JSON data, do
//
//     final appliedJobsResponse = appliedJobsResponseFromJson(jsonString);

import 'dart:convert';

AppliedJobsResponse appliedJobsResponseFromJson(String str) => AppliedJobsResponse.fromJson(json.decode(str));

String appliedJobsResponseToJson(AppliedJobsResponse data) => json.encode(data.toJson());

class AppliedJobsResponse {
    AppliedJobsResponse({
        required this.success,
    });

    Success success;

    factory AppliedJobsResponse.fromJson(Map<String, dynamic> json) => AppliedJobsResponse(
        success: Success.fromJson(json["success"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success.toJson(),
    };
}

class Success {
    Success({
        required this.offers,
        required this.applied,
    });

    List<Applied> offers;
    List<Applied> applied;

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        offers: List<Applied>.from(json["offers"].map((x) => Applied.fromJson(x))),
        applied: List<Applied>.from(json["applied"].map((x) => Applied.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "applied": List<dynamic>.from(applied.map((x) => x.toJson())),
    };
}

class Applied {
    Applied({
        required this.id,
        required this.projectCode,
        required this.clientId,
        required this.categoryId,
        required this.title,
        required this.description,
        required this.rateHour,
        required this.branch,
        required this.required,
        required this.selected,
        required this.requiredAt,
        required this.responsibilities,
        required this.workingHours,
        required this.hiringType,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.appliedStatus,
    });

    int id;
    String projectCode;
    String clientId;
    String categoryId;
    String title;
    String description;
    String rateHour;
    String branch;
    int required;
    int selected;
    DateTime requiredAt;
    String responsibilities;
    String workingHours;
    String hiringType;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String appliedStatus;

    factory Applied.fromJson(Map<String, dynamic> json) => Applied(
        id: json["id"],
        projectCode: json["project_code"],
        clientId: json["client_id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"],
        rateHour: json["rate_hour"],
        branch: json["branch"],
        required: json["required"],
        selected: json["selected"],
        requiredAt: DateTime.parse(json["required_at"]),
        responsibilities: json["responsibilities"],
        workingHours: json["working_hours"],
        hiringType: json["hiring_type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        appliedStatus: json["applied_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "project_code": projectCode,
        "client_id": clientId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "rate_hour": rateHour,
        "branch": branch,
        "required": required,
        "selected": selected,
        "required_at": "${requiredAt.year.toString().padLeft(4, '0')}-${requiredAt.month.toString().padLeft(2, '0')}-${requiredAt.day.toString().padLeft(2, '0')}",
        "responsibilities": responsibilities,
        "working_hours": workingHours,
        "hiring_type": hiringType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "applied_status": appliedStatus,
    };
}
