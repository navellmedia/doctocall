// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.fullName,
    this.company,
    this.age,
  });

  String? fullName;
  String? company;
  int? age;

  factory Users.fromDocumentSnapshot({required DocumentSnapshot<Map<String,dynamic>> doc}){
    return Users(
      fullName: doc.data()!["fullName"],
      company:doc.data()!["company"],
        age:doc.data()!["age"]
    );
  }

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    fullName: json["full_name"],
    company: json["company"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "company": company,
    "age": age,
  };
}
