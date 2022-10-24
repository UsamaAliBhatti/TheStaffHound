// To parse this JSON data, do
//
//     final forgotPasswordEmailResponse = forgotPasswordEmailResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordEmailResponse forgotPasswordEmailResponseFromJson(String str) => ForgotPasswordEmailResponse.fromJson(json.decode(str));

String forgotPasswordEmailResponseToJson(ForgotPasswordEmailResponse data) => json.encode(data.toJson());

class ForgotPasswordEmailResponse {
    ForgotPasswordEmailResponse({
        this.status,
        this.data,
    });

    String? status;
    String? data;

    factory ForgotPasswordEmailResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordEmailResponse(
        status: json["status"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
    };
}
