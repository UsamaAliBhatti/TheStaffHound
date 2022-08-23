// To parse this JSON data, do
//
//     final resumeResponse = resumeResponseFromJson(jsonString);

import 'dart:convert';

ResumeResponse resumeResponseFromJson(String str) => ResumeResponse.fromJson(json.decode(str));

String resumeResponseToJson(ResumeResponse data) => json.encode(data.toJson());

class ResumeResponse {
    ResumeResponse({
        this.id,
        this.userId,
        this.aboutMe,
        this.phone,
        this.education,
        this.experience,
        this.skills,
        this.languages,
        this.address,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? userId;
    String? aboutMe;
    String? phone;
    String? education;
    String? experience;
    String? skills;
    String? languages;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory ResumeResponse.fromJson(Map<String, dynamic> json) => ResumeResponse(
        id: json["id"],
        userId: json["user_id"],
        aboutMe: json["about_me"],
        phone: json["phone"],
        education: json["education"],
        experience: json["experience"],
        skills: json["skills"],
        languages: json["languages"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "about_me": aboutMe,
        "phone": phone,
        "education": education,
        "experience": experience,
        "skills": skills,
        "languages": languages,
        "address": address,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
