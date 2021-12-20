import 'dart:convert';
import 'dart:io';

import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
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

  static void  setUserData() async {
    try {
      var token = await SessionManagement.getToken();
      var client = http.Client();
      var url = Uri.https('presline-api.navel.id', '/api/get_user');
      var res = await client.get(url,
          headers: {"Content-Type": "Application/JSON",
          "Authorization": token});

      var userResponse = userResponseFromJson(res.body);
      await SessionManagement.setUserData(userResponse);
    } catch (e) {
      print(e.toString());
    }
  }
}
