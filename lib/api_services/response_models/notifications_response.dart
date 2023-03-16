// To parse this JSON data, do
//
//     final offerNotificationResponse = offerNotificationResponseFromJson(jsonString);

import 'dart:convert';

OfferNotificationResponse offerNotificationResponseFromJson(String str) =>
    OfferNotificationResponse.fromJson(json.decode(str));

String offerNotificationResponseToJson(OfferNotificationResponse data) =>
    json.encode(data.toJson());

class OfferNotificationResponse {
  OfferNotificationResponse({
    required this.success,
  });

  Success success;

  factory OfferNotificationResponse.fromJson(Map<String, dynamic> json) =>
      OfferNotificationResponse(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success.toJson(),
      };
}

class Success {
  Success({
    required this.offers,
    required this.approvedRequests,
  });

  ApprovedRequests offers;
  ApprovedRequests approvedRequests;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        offers: ApprovedRequests.fromJson(json["offers"]),
        approvedRequests: ApprovedRequests.fromJson(json["approved_requests"]),
      );

  Map<String, dynamic> toJson() => {
        "offers": offers.toJson(),
        "approved_requests": approvedRequests.toJson(),
      };
}

class ApprovedRequests {
  ApprovedRequests({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int? currentPage;
  List<Data> data;
  String firstPageUrl;
  int? from;
  int? lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory ApprovedRequests.fromJson(Map<String, dynamic> json) =>
      ApprovedRequests(
        currentPage: json["current_page"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Data {
  Data({
    required this.id,
    required this.jobseekerId,
    required this.projectId,
    required this.status,
    required this.isSeen,
    required this.confirmation,
    required this.table,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  int id;
  int jobseekerId;
  String projectId;
  String status;
  String isSeen;
  String confirmation;
  String table;
  DateTime createdAt;
  DateTime updatedAt;
  String title;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        jobseekerId: json["jobseeker_id"],
        projectId: json["project_id"],
        status: json["status"],
        isSeen: json["is_seen"],
        confirmation: json["confirmation"],
        table: json["table"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobseeker_id": jobseekerId,
        "project_id": projectId,
        "status": status,
        "is_seen": isSeen,
        "confirmation": confirmation,
        "table": table,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": title,
      };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
