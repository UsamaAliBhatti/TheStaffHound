// To parse this JSON data, do
//
//     final notificationsResponse = notificationsResponseFromJson(jsonString);

import 'dart:convert';

NotificationsResponse notificationsResponseFromJson(String str) => NotificationsResponse.fromJson(json.decode(str));

String notificationsResponseToJson(NotificationsResponse data) => json.encode(data.toJson());

class NotificationsResponse {
    NotificationsResponse({
        this.message,
        this.application,
    });

    String? message;
    List<Application>? application;

    factory NotificationsResponse.fromJson(Map<String, dynamic> json) => NotificationsResponse(
        message: json["message"],
        application: List<Application>.from(json["application"].map((x) => Application.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "application": List<dynamic>.from(application!.map((x) => x.toJson())),
    };
}

class Application {
    Application({
        this.id,
        this.receiverId,
        this.notiTitle,
        this.notiBody,
        this.branchId,
        this.notifyType,
        this.jobId,
        this.status,
        this.seekerStatus,
        this.redirectTo,
        this.jobResponce,
        this.createdAt,
        this.deletedAt,
        this.updatedAt,
    });

    int? id;
    String? receiverId;
    String? notiTitle;
    String? notiBody;
    String? branchId;
    String? notifyType;
    String? jobId;
    String? status;
    String? seekerStatus;
    String? redirectTo;
    String? jobResponce;
    DateTime? createdAt;
    dynamic deletedAt;
    DateTime? updatedAt;

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        receiverId: json["receiver_id"],
        notiTitle: json["noti_title"],
        notiBody: json["noti_body"],
        branchId: json["branch_id"],
        notifyType: json["notify_type"],
        jobId: json["job_id"],
        status: json["status"],
        seekerStatus: json["seeker_status"],
        redirectTo: json["redirect_to"],
        jobResponce: json["job_responce"],
        createdAt: DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "receiver_id": receiverId,
        "noti_title": notiTitle,
        "noti_body": notiBody,
        "branch_id": branchId,
        "notify_type": notifyType,
        "job_id": jobId,
        "status": status,
        "seeker_status": seekerStatus,
        "redirect_to": redirectTo,
        "job_responce": jobResponce,
        "created_at": createdAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "updated_at": updatedAt!.toIso8601String(),
    };
}
