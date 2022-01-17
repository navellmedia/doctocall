// To parse this JSON data, do
//
//     final kategory = kategoryFromJson(jsonString);

import 'dart:convert';

Kategory kategoryFromJson(String str) => Kategory.fromJson(json.decode(str));

String kategoryToJson(Kategory data) => json.encode(data.toJson());

class Kategory {
  Kategory({
    this.kode,
    this.kategori,
  });

  String? kode;
  String? kategori;

  factory Kategory.fromJson(Map<String, dynamic> json) => Kategory(
    kode: json["kode"],
    kategori: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "kode": kode,
    "kategori": kategori,
  };
}
