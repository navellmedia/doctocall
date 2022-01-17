// To parse this JSON data, do
//
//     final kategory = kategoryFromJson(jsonString);

import 'dart:convert';

Kategory kategoryFromJson(String str) => Kategory.fromJson(json.decode(str));

String kategoryToJson(Kategory data) => json.encode(data.toJson());

class Kategory {
  Kategory({
    this.id,
    this.kode,
    this.kategori,
  });

  String? id;
  String? kode;
  String? kategori;

  factory Kategory.fromJson(Map<String, dynamic> json) => Kategory(
    id: json["id"],
    kode: json["kode"],
    kategori: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kode": kode,
    "kategori": kategori,
  };
}
