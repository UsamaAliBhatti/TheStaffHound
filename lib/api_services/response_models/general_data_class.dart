class Data {
  Data({
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
    this.savedJob,
  });

  int id;
  String clientId;
  String title;
  String? description;
  String rateHour;
  String branch;
  int required;
  dynamic selected;
  DateTime? requiredAt;
  String? responsibilities;
  String? workingHours;
  dynamic hiringType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  SavedJob? savedJob;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        clientId: json["client_id"],
        title: json["title"],
        description: json["description"],
        rateHour: json["rate_hour"],
        branch: json["branch"],
        required: json["required"],
        selected: json["selected"],
        requiredAt: json["required_at"] == null
            ? null
            : DateTime.parse(json["required_at"]),
        responsibilities: json["responsibilities"],
        workingHours: json["working_hours"],
        hiringType: json["hiring_type"],
        status: json["status"] ?? {},
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        savedJob: json["saved_job"] == null
            ? null
            : SavedJob.fromJson(json["saved_job"]),
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
        "required_at":
            "${requiredAt!.year.toString().padLeft(4, '0')}-${requiredAt!.month.toString().padLeft(2, '0')}-${requiredAt!.day.toString().padLeft(2, '0')}",
        "responsibilities": responsibilities,
        "working_hours": workingHours,
        "hiring_type": hiringType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "saved_job": savedJob?.toJson(),
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
