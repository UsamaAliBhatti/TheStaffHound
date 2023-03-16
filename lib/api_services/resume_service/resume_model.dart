// To parse this JSON data, do
//
//     final resumeModel = resumeModelFromJson(jsonString);

import 'dart:convert';

ResumeModel resumeModelFromJson(String str) => ResumeModel.fromJson(json.decode(str));

String resumeModelToJson(ResumeModel data) => json.encode(data.toJson());

class ResumeModel {
    ResumeModel({
        required this.data,
    });

    List<Datum> data;

    factory ResumeModel.fromJson(Map<String, dynamic> json) => ResumeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.userId,
        required this.skills,
        required this.languages,
        required this.aboutMe,
        required this.createdAt,
        required this.updatedAt,
        required this.education,
        required this.experience,
    });

    int id;
    int userId;
    String skills;
    String languages;
    String aboutMe;
    DateTime createdAt;
    DateTime updatedAt;
    List<Education> education;
    List<Experience> experience;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        skills: json["skills"],
        languages: json["languages"],
        aboutMe: json["about_me"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        education: List<Education>.from(json["education"].map((x) => Education.fromJson(x))),
        experience: List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "skills": skills,
        "languages": languages,
        "about_me": aboutMe,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "experience": List<dynamic>.from(experience.map((x) => x.toJson())),
    };
}

class Education {
    Education({
        required this.id,
        required this.userId,
        required this.qualification,
        required this.institute,
        required this.startDate,
        required this.endDate,
    });

    int id;
    int userId;
    String qualification;
    String institute;
    DateTime startDate;
    DateTime endDate;

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        userId: json["user_id"],
        qualification: json["qualification"],
        institute: json["institute"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "qualification": qualification,
        "institute": institute,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    };
}

class Experience {
    Experience({
        required this.id,
        required this.userId,
        required this.company,
        required this.designation,
        required this.startDate,
        required this.endDate,
    });

    int id;
    int userId;
    String company;
    String designation;
    DateTime startDate;
    DateTime endDate;

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        userId: json["user_id"],
        company: json["company"],
        designation: json["designation"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company": company,
        "designation": designation,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    };
}
