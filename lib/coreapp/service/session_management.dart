import 'dart:convert';

import 'package:doctorcall/features/login_feature/models/login_response.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement{
  static setLogin(String? token) async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    await pref.setString("token", token!);
    await pref.setBool("isLogin", true);
  }

  static setUserData(UserResponse user) async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var toJson = json.encode(user.toJson());
    await pref.setString("user", toJson);
  }

  static Future<UserResponse> getUserData() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var userJson = pref.getString("user");
    if(userJson==null) return UserResponse();
    return UserResponse.fromJson(json.decode(userJson));
  }

  static Future<String> getToken() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var token = await pref.getString("token");
    return "Bearer ${token!}";
  }

  static Future<bool> chekIslogin() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var isLogin = await pref.getBool("isLogin");
    return isLogin??false;
  }

  static Future<bool> isFirstTime() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var isLogin = await pref.getBool("isFirstTime");
    return isLogin??true;
  }

  static setIsFirstTime() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    await pref.setBool("isFirstTime", false);
  }

  static setLogout() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    await pref.remove("isLogin");
    await pref.remove("token");
  }

  static setImageProfile(String? img_profile) async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    await pref.setString("img_profile", img_profile!);
  }

  static Future<String> getImageProfile() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var img = await pref.getString("img_profile");
    return img??"";
  }
}