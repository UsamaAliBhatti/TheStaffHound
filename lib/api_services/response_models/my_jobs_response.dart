// To parse this JSON data, do
//
//     final myJobsResponse = myJobsResponseFromJson(jsonString);

import 'dart:convert';

MyJobsResponse myJobsResponseFromJson(String str) =>
    MyJobsResponse.fromJson(json.decode(str));

String myJobsResponseToJson(MyJobsResponse data) => json.encode(data.toJson());

class MyJobsResponse {
  MyJobsResponse({
    this.appliedJobs,
    // this.waitingJobs,
    this.approvedJobs,
    this.rejectedJobs,
    this.completedJobs,
  });

  List<Job>? appliedJobs;
  // List<Job>? waitingJobs;
  List<Job>? approvedJobs;
  List<Job>? rejectedJobs;
  List<Job>? completedJobs;

  factory MyJobsResponse.fromJson(Map<String, dynamic> json) => MyJobsResponse(
        appliedJobs:
            List<Job>.from(json["applied_jobs"].map((x) => Job.fromJson(x))),
        /* waitingJobs:
            List<Job>.from(json["waiting_jobs"].map((x) => Job.fromJson(x))), */
        approvedJobs:
            List<Job>.from(json["approved_jobs"].map((x) => Job.fromJson(x))),
        rejectedJobs:
            List<Job>.from(json["rejected_jobs"].map((x) => Job.fromJson(x))),
        completedJobs: List<Job>.from(json["completed_jobs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "applied_jobs": List<dynamic>.from(appliedJobs!.map((x) => x.toJson())),
        // "waiting_jobs": List<dynamic>.from(waitingJobs!.map((x) => x.toJson())),
        "approved_jobs":
            List<dynamic>.from(approvedJobs!.map((x) => x.toJson())),
        "rejected_jobs":
            List<dynamic>.from(rejectedJobs!.map((x) => x.toJson())),
        "completed_jobs": List<dynamic>.from(completedJobs!.map((x) => x)),
      };
}

class Job {
  Job({
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
  String? companyId;
  String? salary;
  String? location;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
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
