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
    this.error,
  });

  bool? success;
  String? message;
  String? token;
  String? error;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "error": error,
  };
}
