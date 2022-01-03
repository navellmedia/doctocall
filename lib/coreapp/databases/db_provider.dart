import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'notofication_model.dart';

// create/insert, update, delete, read
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();

    return _database!;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "doctor.db");

    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(""
          "CREATE TABLE Notification ("
          "id INTEGER PRIMARY KEY,"
          "subject TEXT,"
          "body TEXT,"
          "isread INTEGER)");
    });
  }

  insertData(NotificationModel notif) async {
    final db = await database;

    var raw = await db.rawInsert(""
        ''
        "INSERT INTO Notification (id,subject,body,isread)"
        " VALUES ('${notif.id}', '${notif.subject}','${notif.body}','${notif.isread}')");

    return raw;
  }

  Future<List<NotificationModel>> getDataAll() async {
    final db = await database;
    var res =
        await db.query("Notification"); //, where: "id=?", whereArgs: [1]);

    List<NotificationModel> list = res.isEmpty
        ? []
        : res.map((e) => NotificationModel.fromJson(e)).toList();
    return list;
  }

  Future<List<NotificationModel>> getDataById(int id) async {
    final db = await database;
    var res = await db.query("Notification", where: "id=?", whereArgs: [id]);

    List<NotificationModel> list = res.isEmpty
        ? []
        : res.map((e) => NotificationModel.fromJson(e)).toList();
    return list;
  }

  deleteById(int id) async {
    final db = await database;
    return db.delete("Notification", where: "id=?", whereArgs: [id]);
  }

  updateById(NotificationModel notif) async {
    final db = await database;
    var res = await db.update("Notification", notif.toJson(),
        where: "id=?", whereArgs: [notif.id]);
  }
}
