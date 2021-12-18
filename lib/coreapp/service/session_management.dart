import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement{
  static setLogin(String token) async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    await pref.setString("token", token);
    await pref.setBool("isLogin", true);
  }

  static Future<String> getToken() async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    var token = await pref.getString("token");
    return token!;
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
}