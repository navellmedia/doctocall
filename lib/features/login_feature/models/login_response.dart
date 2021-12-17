// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.token,
  });

  bool? success;
  String? message;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
  };
}
