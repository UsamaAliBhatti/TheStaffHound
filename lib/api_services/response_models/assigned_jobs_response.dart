// To parse this JSON data, do
//
//     final assignedJobsResponse = assignedJobsResponseFromJson(jsonString);

import 'dart:convert';

AssignedJobsResponse assignedJobsResponseFromJson(String str) =>
    AssignedJobsResponse.fromJson(json.decode(str));

String assignedJobsResponseToJson(AssignedJobsResponse data) =>
    json.encode(data.toJson());

class AssignedJobsResponse {
  AssignedJobsResponse({
    required this.success,
  });

  List<Success> success;

  factory AssignedJobsResponse.fromJson(Map<String, dynamic> json) =>
      AssignedJobsResponse(
        success:
            List<Success>.from(json["success"].map((x) => Success.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x.toJson())),
      };
}

class Success {
  Success({
    required this.id,
    required this.clientId,
    required this.title,
    required this.description,
    required this.rateHour,
    required this.branch,
    required this.required,
    this.selected,
    required this.requiredAt,
    required this.responsibilities,
    required this.workingHours,
    this.hiringType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String clientId;
  String title;
  String description;
  String rateHour;
  String branch;
  int required;
  dynamic selected;
  DateTime requiredAt;
  String responsibilities;
  String workingHours;
  dynamic hiringType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        clientId: json["client_id"],
        title: json["title"],
        description: json["description"] ?? '',
        rateHour: json["rate_hour"],
        branch: json["branch"],
        required: json["required"],
        selected: json["selected"],
        requiredAt: DateTime.parse(
            json["required_at"] ?? DateTime.now().toIso8601String()),
        responsibilities: json["responsibilities"] ?? '',
        workingHours: json["working_hours"] ?? '',
        hiringType: json["hiring_type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "title": title,
        "description": description,
        "rate_hour": rateHour,
        "branch": branch,
        "required": required,
        "selected": selected,
        "required_at":
            "${requiredAt.year.toString().padLeft(4, '0')}-${requiredAt.month.toString().padLeft(2, '0')}-${requiredAt.day.toString().padLeft(2, '0')}",
        "responsibilities": responsibilities,
        "working_hours": workingHours,
        "hiring_type": hiringType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
