// To parse this JSON data, do
//
//     final jobDetail = jobDetailFromJson(jsonString);

import 'dart:convert';

JobDetail jobDetailFromJson(String str) => JobDetail.fromJson(json.decode(str));

String jobDetailToJson(JobDetail data) => json.encode(data.toJson());

class JobDetail {
  JobDetail({
    // this.jobApplicants,
    this.jobs,
    this.client,
  });

  // JobApplicants? jobApplicants;
  Jobs? jobs;
  Client? client;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
        /* jobApplicants: JobApplicants.fromJson(
            json["job_applicants"] ?? {"status": "Empty"}), */
        jobs: Jobs.fromJson(json["jobs"]),
        client: Client.fromJson(json["client"] ??
            {
              "id": null,
              "owner_first_name": 'ownerFirstName',
              "owner_last_name": 'ownerLastName',
              "company_name": 'companyName',
              "company_web": 'companyWeb',
              "email": 'email',
              "phone": 'phone',
              "password": 'password',
              "password_confirmation": 'passwordConfirmation',
              "street1": 'street1',
              "street2": 'street2',
              "state": 'state',
              "zip_code": 'zipCode',
              "country": 'country',
              "hours_start": 'hoursStart',
              "hours_end": 'hoursEnd',
              "description": 'description',
              "status": 'status',
              "payment_status": 'paymentStatus',
              "job_num": 'jobNum',
              "user_id": 'userId',
              "branch_id": 'branchId',
              "agency_id": 'agencyId',
              "created_at": DateTime.now().toIso8601String(),
              "updated_at": DateTime.now().toIso8601String(),
            }),
      );

  Map<String, dynamic> toJson() => {
        // "job_applicants": jobApplicants!.toJson(),
        "jobs": jobs!.toJson(),
        "client": client!.toJson(),
      };
}

class Client {
  Client({
    this.id,
    this.ownerFirstName,
    this.ownerLastName,
    this.companyName,
    this.companyWeb,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.street1,
    this.street2,
    this.state,
    this.zipCode,
    this.country,
    this.hoursStart,
    this.hoursEnd,
    this.description,
    this.status,
    this.paymentStatus,
    this.jobNum,
    this.userId,
    this.branchId,
    this.agencyId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? ownerFirstName;
  String? ownerLastName;
  String? companyName;
  String? companyWeb;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? street1;
  String? street2;
  String? state;
  String? zipCode;
  String? country;
  String? hoursStart;
  String? hoursEnd;
  String? description;
  String? status;
  String? paymentStatus;
  String? jobNum;
  String? userId;
  String? branchId;
  String? agencyId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        ownerFirstName: json["owner_first_name"],
        ownerLastName: json["owner_last_name"],
        companyName: json["company_name"],
        companyWeb: json["company_web"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        street1: json["street1"],
        street2: json["street2"],
        state: json["state"],
        zipCode: json["zip_code"],
        country: json["country"],
        hoursStart: json["hours_start"],
        hoursEnd: json["hours_end"],
        description: json["description"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        jobNum: json["job_num"],
        userId: json["user_id"],
        branchId: json["branch_id"],
        agencyId: json["agency_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_first_name": ownerFirstName,
        "owner_last_name": ownerLastName,
        "company_name": companyName,
        "company_web": companyWeb,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "street1": street1,
        "street2": street2,
        "state": state,
        "zip_code": zipCode,
        "country": country,
        "hours_start": hoursStart,
        "hours_end": hoursEnd,
        "description": description,
        "status": status,
        "payment_status": paymentStatus,
        "job_num": jobNum,
        "user_id": userId,
        "branch_id": branchId,
        "agency_id": agencyId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

/* class JobApplicants {
  JobApplicants({
    this.status,
  });

  String? status;

  factory JobApplicants.fromJson(Map<String, dynamic> json) => JobApplicants(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
} */

class Jobs {
  Jobs({
    this.id,
    this.companyName,
    this.projectName,
    this.jobTitle,
    this.companyId,
    this.categoryId,
    this.location,
    this.jobOrigin,
    this.hiringNumbers,
    this.remainingPost,
    this.jobType,
    this.salary,
    this.joiningDate,
    this.jobDeadline,
    this.description,
    this.education,
    this.experience,
    this.imageUrl,
    this.branchId,
    this.clientId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.salaryMode,
    this.frequency,
    this.startDate,
    this.endDate,
    this.daysOfWeek,
    this.startTime,
    this.endTime,
    this.breakTime,
    this.breakSalary,
    this.totalHours,
    this.skillDescription,
    this.jobDescription,
    this.skillsArray,
    this.branchStatus,
    this.approvalStatus,
  });

  int? id;
  String? companyName;
  String? projectName;
  String? jobTitle;
  String? companyId;
  int? categoryId;
  String? location;
  String? jobOrigin;
  String? hiringNumbers;
  String? remainingPost;
  String? jobType;
  String? salary;
  String? joiningDate;
  String? jobDeadline;
  String? description;
  String? education;
  String? experience;
  String? imageUrl;
  String? branchId;
  String? clientId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? salaryMode;
  String? frequency;
  DateTime? startDate;
  DateTime? endDate;
  String? daysOfWeek;
  String? startTime;
  String? endTime;
  String? breakTime;
  String? breakSalary;
  String? totalHours;
  String? skillDescription;
  String? jobDescription;
  String? skillsArray;
  String? branchStatus;
  String? approvalStatus;

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        id: json["id"],
        companyName: json["company_name"],
        projectName: json["project_name"],
        jobTitle: json["job_title"],
        companyId: json["company_id"],
        categoryId: json["category_id"],
        location: json["location"],
        jobOrigin: json["job_origin"],
        hiringNumbers: json["hiring_numbers"],
        remainingPost: json["remaining_post"],
        jobType: json["job_type"],
        salary: json["salary"],
        joiningDate: json["joining_date"],
        jobDeadline: json["job_deadline"],
        description: json["description"],
        education: json["education"],
        experience: json["experience"],
        imageUrl: json["image_url"],
        branchId: json["branch_id"],
        clientId: json["client_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        salaryMode: json["salary_mode"],
        frequency: json["frequency"],
        /*   startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]), */
        daysOfWeek: json["days_of_week"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        breakTime: json["break_time"],
        breakSalary: json["break_salary"],
        totalHours: json["total_hours"],
        skillDescription: json["skill_description"],
        jobDescription: json["job_description"],
        skillsArray: json["skills_array"],
        branchStatus: json["branch_status"],
        approvalStatus: json["approval_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "project_name": projectName,
        "job_title": jobTitle,
        "company_id": companyId,
        "category_id": categoryId,
        "location": location,
        "job_origin": jobOrigin,
        "hiring_numbers": hiringNumbers,
        "remaining_post": remainingPost,
        "job_type": jobType,
        "salary": salary,
        "joining_date": joiningDate,
        "job_deadline": jobDeadline,
        "description": description,
        "education": education,
        "experience": experience,
        "image_url": imageUrl,
        "branch_id": branchId,
        "client_id": clientId,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "salary_mode": salaryMode,
        "frequency": frequency,
        // "start_date": startDate!.toIso8601String(),
        // "end_date": endDate!.toIso8601String(),
        "days_of_week": daysOfWeek,
        "start_time": startTime,
        "end_time": endTime,
        "break_time": breakTime,
        "break_salary": breakSalary,
        "total_hours": totalHours,
        "skill_description": skillDescription,
        "job_description": jobDescription,
        "skills_array": skillsArray,
        "branch_status": branchStatus,
        "approval_status": approvalStatus,
      };
}
