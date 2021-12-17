// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

NewsResponse newsResponseFromJson(String str) => NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  NewsResponse({
    this.error,
    this.data,
  });

  String? error;
  List<Datum>? data;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    error: json["error"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.subtitle,
    this.body,
    this.tanggal,
    this.imgUrl,
    this.iscative,
    this.createdAt,
    this.updatedAt,
    this.author,
  });

  int? id;
  String? title;
  String? subtitle;
  String? body;
  String? tanggal;
  String? imgUrl;
  int? iscative;
  dynamic createdAt;
  dynamic updatedAt;
  String? author;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    body: json["body"],
    tanggal: json["tanggal"],
    imgUrl: json["img_url"],
    iscative: json["iscative"] == null ? null : json["iscative"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    author: json["author"] == null ? null : json["author"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "body": body,
    "tanggal": tanggal,
    "img_url": imgUrl,
    "iscative": iscative == null ? null : iscative,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "author": author == null ? null : author,
  };
}
