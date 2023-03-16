// To parse this JSON data, do
//
//     final dashboardOffersResponse = dashboardOffersResponseFromJson(jsonString);

import 'dart:convert';

DashboardOffersResponse dashboardOffersResponseFromJson(String str) =>
    DashboardOffersResponse.fromJson(json.decode(str));

String dashboardOffersResponseToJson(DashboardOffersResponse data) =>
    json.encode(data.toJson());

class DashboardOffersResponse {
  DashboardOffersResponse({
    required this.offers,
  });

  List<Offer> offers;

  factory DashboardOffersResponse.fromJson(Map<String, dynamic> json) =>
      DashboardOffersResponse(
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    required this.id,
    required this.jobseekerId,
    required this.projectId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.clientId,
    required this.categoryId,
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
  });

  int id;
  int jobseekerId;
  String projectId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String clientId;
  String categoryId;
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

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        jobseekerId: json["jobseeker_id"],
        projectId: json["project_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        clientId: json["client_id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"] ?? '',
        rateHour: json["rate_hour"],
        branch: json["branch"],
        required: json["required"],
        selected: json["selected"],
        requiredAt:
            DateTime.parse(json["required_at"] ?? DateTime.now().toString()),
        responsibilities: json["responsibilities"] ?? '',
        workingHours: json["working_hours"] ?? '',
        hiringType: json["hiring_type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobseeker_id": jobseekerId,
        "project_id": projectId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "client_id": clientId,
        "category_id": categoryId,
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
      };
}
