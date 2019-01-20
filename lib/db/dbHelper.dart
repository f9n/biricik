import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:biricik/models/resource.dart';

class DbHelper {
  String tableResource = "Resources";
  String colId = "Id";
  String colDescription = "Description";
  String colName = "Name";
  String colUrl = "Url";

  static Database _db;
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "biricik-resources.db";

    var dbResources = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbResources;
  }

  Future<Database> _createDb(Database db, int version) async {
    await db.execute(
        "Create table $tableResource($colId integer primary key, $colName text, $colDescription text, $colUrl text)");
  }

  Future<int> insert(Resource resource) async {
    Database db = await this.db;
    var result = await db.insert(tableResource, resource.toMap());
    return result;
  }

  Future<int> update(Resource resource) async {
    Database db = await this.db;
    var result = await db.update(tableResource, resource.toMap(),
        where: "$colId =?", whereArgs: [resource.id]);

    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result =
        await db.rawDelete("Delete from $tableResource where $colId = $id");
    return result;
  }

  Future<List<Resource>> getResources() async {
    Database db = await this.db;
    List<Resource> resources = new List<Resource>();
    var result = await db.rawQuery("Select * from $tableResource");
    for (var resourceObj in result) {
      resources.add(Resource.fromObject(resourceObj));
    }
    return resources;
  }
}
