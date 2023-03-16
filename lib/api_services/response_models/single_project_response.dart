// To parse this JSON data, do
//
//     final singleProjectResponse = singleProjectResponseFromJson(jsonString);

import 'dart:convert';

SingleProjectResponse singleProjectResponseFromJson(String str) =>
    SingleProjectResponse.fromJson(json.decode(str));

String singleProjectResponseToJson(SingleProjectResponse data) =>
    json.encode(data.toJson());

class SingleProjectResponse {
  SingleProjectResponse({
    this.success,
  });

  Success? success;

  factory SingleProjectResponse.fromJson(Map<String, dynamic> json) =>
      SingleProjectResponse(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success!.toJson(),
      };
}

class Success {
  Success({
    required this.id,
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
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.savedJob,
    required this.client,
  });

  int id;
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
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  SavedJob? savedJob;
  Client? client;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
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
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        savedJob: SavedJob.fromJson(json["saved_job"] ??
            {
              "id": 0,
              "jobseeker_id": 0,
              "project_id": '0',
              "status": '0',
              "created_at": DateTime.now().toIso8601String(),
              "updated_at": DateTime.now().toIso8601String(),
            }),
        client: Client.fromJson(json["client"]),
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
        "required_at": requiredAt,
        "responsibilities": responsibilities,
        "working_hours": workingHours,
        "hiring_type": hiringType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "saved_job": savedJob!.toJson(),
        "client": client!.toJson(),
      };
}

class Client {
  Client({
    required this.id,
    required this.userId,
    required this.branchId,
    required this.name,
    this.companyName,
    required this.companyRegistrationNo,
    required this.businessCategory,
    this.designation,
    required this.email,
    required this.phone,
    required this.companyAddress,
    required this.state,
    required this.zipCode,
    required this.city,
    required this.country,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String userId;
  String branchId;
  String name;
  dynamic companyName;
  String companyRegistrationNo;
  String businessCategory;
  dynamic designation;
  String email;
  String phone;
  String companyAddress;
  String state;
  String zipCode;
  String city;
  String country;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        userId: json["user_id"],
        branchId: json["branch_id"],
        name: json["name"],
        companyName: json["company_name"],
        companyRegistrationNo: json["company_registration_no"],
        businessCategory: json["business_category"],
        designation: json["designation"],
        email: json["email"],
        phone: json["phone"],
        companyAddress: json["company_address"],
        state: json["state"],
        zipCode: json["zip_code"],
        city: json["city"],
        country: json["country"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ,
        "user_id": userId,
        "branch_id": branchId,
        "name": name,
        "company_name": companyName,
        "company_registration_no": companyRegistrationNo,
        "business_category": businessCategory,
        "designation": designation,
        "email": email,
        "phone": phone,
        "company_address": companyAddress,
        "state": state,
        "zip_code": zipCode,
        "city": city,
        "country": country,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SavedJob {
  SavedJob({
    required this.id,
    required this.jobseekerId,
    required this.projectId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int jobseekerId;
  String projectId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory SavedJob.fromJson(Map<String, dynamic> json) => SavedJob(
        id: json["id"],
        jobseekerId: json["jobseeker_id"],
        projectId: json["project_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobseeker_id": jobseekerId,
        "project_id": projectId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
