// To parse this JSON data, do
//
//     final jobsResponse = jobsResponseFromJson(jsonString);

import 'dart:convert';

JobsResponse jobsResponseFromJson(String str) =>
    JobsResponse.fromJson(json.decode(str));

String jobsResponseToJson(JobsResponse data) => json.encode(data.toJson());

class JobsResponse {
  JobsResponse({
    this.recentJobs,
  });

  List<Job>? recentJobs;

  factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        recentJobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jobs": List<dynamic>.from(recentJobs!.map((x) => x.toJson())),
      };
}

class Job {
  Job({
    this.id,
    this.jobTitle,
    this.companyId,
    this.salary,
    this.location,
  });

  int? id;
  String? jobTitle;
  String? companyId;
  String? salary;
  String? location;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        jobTitle: json["job_title"],
        companyId: json["company_id"],
        salary: json["salary"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_title": jobTitle,
        "company_id": companyId,
        "salary": salary,
        "location": location,
      };
}
