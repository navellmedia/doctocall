// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    this.subject,
    this.body,
    this.isread,
  });

  int? id;
  String? subject;
  String? body;
  int? isread;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    subject: json["subject"],
    body: json["body"],
    isread: json["isread"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "body": body,
    "isread": isread,
  };
}
