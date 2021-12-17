import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionService{
  static setCurrentUser(String usr) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //var userJson = json.encode(user.toMap());
      await prefs.setString('current_user', usr);
    }catch(e){
      print(e);
    }
  }

  static Future<String> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //var userJson = json.encode(user.toMap());
    var usr = await prefs.getString('current_user');
    return usr??"";
  }

}