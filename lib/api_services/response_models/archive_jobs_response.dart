// To parse this JSON data, do
//
//     final archivedJobsResponse = archivedJobsResponseFromJson(jsonString);

import 'dart:convert';

List<ArchivedJobsResponse> archivedJobsResponseFromJson(String str) => List<ArchivedJobsResponse>.from(json.decode(str).map((x) => ArchivedJobsResponse.fromJson(x)));

String archivedJobsResponseToJson(List<ArchivedJobsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArchivedJobsResponse {
    ArchivedJobsResponse({
        this.id,
        this.imageUrl,
        this.jobTitle,
        this.companyId,
        this.salary,
        this.location,
    });

    int? id;
    String? imageUrl;
    String? jobTitle;
    int? companyId;
    String? salary;
    String? location;

    factory ArchivedJobsResponse.fromJson(Map<String, dynamic> json) => ArchivedJobsResponse(
        id: json["id"],
        imageUrl: json["image_url"],
        jobTitle: json["job_title"],
        companyId: json["company_id"],
        salary: json["salary"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "job_title": jobTitle,
        "company_id": companyId,
        "salary": salary,
        "location": location,
    };
}
