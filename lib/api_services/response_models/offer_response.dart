// To parse this JSON data, do
//
//     final offerResponse = offerResponseFromJson(jsonString);

import 'dart:convert';

OfferResponse offerResponseFromJson(String str) =>
    OfferResponse.fromJson(json.decode(str));

String offerResponseToJson(OfferResponse data) => json.encode(data.toJson());

class OfferResponse {
  OfferResponse({
    required this.success,
  });

  Success? success;

  factory OfferResponse.fromJson(Map<String, dynamic> json) => OfferResponse(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success!.toJson(),
      };
}

class Success {
  Success({
    required this.id,
    required this.jobseekerId,
    required this.projectId,
    required this.status,
    required this.isSeen,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int jobseekerId;
  String projectId;
  String status;
  String isSeen;
  DateTime createdAt;
  DateTime updatedAt;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        jobseekerId: json["jobseeker_id"],
        projectId: json["project_id"],
        status: json["status"],
        isSeen: json["is_seen"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobseeker_id": jobseekerId,
        "project_id": projectId,
        "status": status,
        "is_seen": isSeen,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
