// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.remarks,
    this.token,
  });

  bool? status;
  String? remarks;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    remarks: json["remarks"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "remarks": remarks,
    "token": token,
  };
}
