// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponse({
    this.jobs,
    this.interview,
    this.categories,
    this.featuredJobs,
    this.recentJobs,
  });

  int? jobs; 
  int? interview;
  List<Category>? categories;
  List<Job>? featuredJobs;
  List<Job>? recentJobs;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        jobs: json["jobs"],
        interview: json["interview"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        featuredJobs:
            List<Job>.from(json["featured_jobs"].map((x) => Job.fromJson(x))),
        recentJobs:
            List<Job>.from(json["recent_jobs"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jobs": jobs,
        "interview": interview,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "featured_jobs":
            List<dynamic>.from(featuredJobs!.map((x) => x.toJson())),
        "recent_jobs": List<dynamic>.from(recentJobs!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.jobTitle,
  });

  int? id;
  String? jobTitle;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        jobTitle: json["job_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_title": jobTitle,
      };
}

class Job {
  Job({
    this.id,
    this.jobTitle,
    this.companyId,
    this.salary,
    this.location,
    this.imageUrl,
  });

  int? id;
  String? jobTitle;
  String? companyId;
  String? salary;
  String? location;
  String? imageUrl;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        jobTitle: json["job_title"],
        companyId: json["company_id"],
        salary: json["salary"],
        location: json["location"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_title": jobTitle,
        "company_id": companyId,
        "salary": salary,
        "location": location,
        "image_url": imageUrl,
      };
}
