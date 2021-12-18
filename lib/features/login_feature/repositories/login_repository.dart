import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:doctorcall/features/login_feature/models/login_request.dart';
import 'package:doctorcall/features/login_feature/models/login_response.dart';

class LoginRepository {
  static Future<LoginResponse?> getLoginData(LogiRequest _param) async {
    try {
      var response = await Dio().post('https://presline-api.navel.id/api/login',
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data:
              jsonEncode({"email": _param.email, "password": _param.password}));

      var loginResponse = loginResponseFromJson(response.data.toString());
      print(loginResponse.token);
      return loginResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<LoginResponse?> getLoginDataHttp(LogiRequest _param) async {
    try {
      var client = http.Client();
      var url = Uri.https('presline-api.navel.id', '/api/login');
      var res = await client.post(url,
          headers: {"Content-Type": "Application/JSON"},
          body: jsonEncode({"email":_param.email, "password": _param.password}));
      var loginResponse = loginResponseFromJson(res.body);
      return loginResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
