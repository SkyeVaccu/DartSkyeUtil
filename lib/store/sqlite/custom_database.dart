import 'package:flutter/widgets.dart';
import 'package:skye_utils/store/sqlite/configuration/sqlite_configuration.dart';
import 'package:skye_utils/util/object_util.dart';
import 'package:skye_utils/util/serialize/serializable.dart';
import 'package:skye_utils/util/serialize/serialize_util.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:skye_utils/extension/string_extension.dart';

///the custom database
class CustomDatabase {
  //the database singleton instance
  static Database? _database;

  ///init the database
  void init() async {
    // Avoid errors caused by flutter upgrade.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    _database = await sqlite.openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        (await sqlite.getDatabasesPath()).join(SqliteConfiguration.DataBaseName + ".db"),
        onCreate: (Database db, int version) {
      SqliteConfiguration.createTableSQLList.forEach((createSQL) {
        db.execute(createSQL);
      });
    });
  }

  ///insert the target obj
  ///@param tableName : the target table
  ///@param obj : the insert object
  ///@param conflictAlgorithm : apply algorithm when happen the conflict
  ///@return : the influence rows
  static Future<int> insert<E extends Serializable>({
    required String tableName,
    required E obj,
    ConflictAlgorithm? conflictAlgorithm,
  }) {
    conflictAlgorithm ??= ConflictAlgorithm.replace;
    return _database!.insert(tableName, obj.toJson(), conflictAlgorithm: conflictAlgorithm);
  }

  ///find the target obj by id
  ///@param tableName : the target table
  ///@param id : the target object id
  ///@param targetObj : target object type
  ///@return : the result object
  static Future<E> findOneById<E extends Serializable>({
    required String tableName,
    required String id,
    required E targetObj,
  }) async {
    List<Map<String, dynamic>> result =
        await _database!.query(tableName, columns: ["id"], where: "id=?", whereArgs: [id]);
    return SerializeUtil.asCustomized(result[0], targetObj);
  }

  ///find all target obj and you can select based on the ownerId
  ///@param tableName : the target table
  ///@param ownerId : the row information owner id
  ///@param targetObj : target object type
  ///@return : the all result object list
  static Future<List<E>> findAll<E extends Serializable>({
    required String tableName,
    String? ownerId,
    required E targetObj,
  }) async {
    if (ObjectUtil.isEmpty(ownerId)) {
      List<Map<String, dynamic>> result = await _database!.query(tableName);
      return SerializeUtil.asCustomized(result, targetObj);
    } else {
      List<Map<String, dynamic>> result = await _database!.query(tableName,
          columns: [SqliteConfiguration.IdentitySign],
          where: SqliteConfiguration.IdentitySign + "=?",
          whereArgs: [ownerId]);
      return SerializeUtil.asCustomized(result, targetObj);
    }
  }

  ///update the info by the id
  ///@param tableName : the target table
  ///@param id : the primary key id
  ///@param targetObj : target object type
  ///@return : the influence rows
  static Future<int> updateOneById<E extends Serializable>({
    required String tableName,
    required String id,
    required E targetObj,
  }) {
    return _database!.update(tableName, targetObj.toJson(), where: "id=?", whereArgs: [id]);
  }

  ///judge whether the target obj exist
  ///@param tableName : the target table
  ///@param id : the primary key id
  ///@return : whether the row exist
  static Future<bool> isExistById<E extends Serializable>({
    required String tableName,
    required String id,
  }) async {
    List<Map<String, dynamic>> result =
        await _database!.query(tableName, columns: ["id"], where: "id=?", whereArgs: [id]);
    return result.length > 0;
  }

  ///delete the obj by id
  ///@param tableName : the target table
  ///@param id : the primary key id
  ///@return : the influence rows
  static Future<int> deleteOneById<E extends Serializable>({
    required String tableName,
    required String id,
  }) {
    return _database!.delete(tableName, where: "id=?", whereArgs: [id]);
  }

  ///you can custom the sql to select data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the result obj list
  static Future<List<Map<String, dynamic>>> rawQuery({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawQuery(sql, arguments);
  }

  ///you can custom the sql to select data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the influence rows
  static Future<int> rawUpdate({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawUpdate(sql, arguments);
  }

  ///you can custom the sql to insert data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the influence rows
  static Future<int> rawInsert({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawInsert(sql, arguments);
  }

  ///you can custom the sql to delete data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the influence rows
  static Future<int> rawDelete({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawDelete(sql, arguments);
  }
}
