// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) => DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) => json.encode(data.toJson());

class DashboardResponse {
    DashboardResponse({
        required this.savedJobCounter,
        required this.assignedJobCounter,
    });

    int savedJobCounter;
    int assignedJobCounter;

    factory DashboardResponse.fromJson(Map<String, dynamic> json) => DashboardResponse(
        savedJobCounter: json["saved_job_counter"],
        assignedJobCounter: json["assigned_job_counter"],
    );

    Map<String, dynamic> toJson() => {
        "saved_job_counter": savedJobCounter,
        "assigned_job_counter": assignedJobCounter,
    };
}
