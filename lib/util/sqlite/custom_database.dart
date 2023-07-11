import 'package:flutter/widgets.dart';
import '../../util/logger_util.dart';
import '../../util/object_util.dart';
import '../../util/serialize/serializable.dart';
import '../../util/serialize/serialize_util.dart';
import '../../util/sqlite/database_table.dart';
import '../../util/sqlite/sqlite_data_type.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import '../../extension/string_extension.dart';

///the custom database
class CustomDatabase {
  //the data base name
  String databaseName;

  //the identity sign which assign the owner like the userId as the foreign key in the normal table
  String identitySign;

  //all database tables in the database
  List<DatabaseTable> databaseTableList;

  //the true database object
  Database? _database;

  ///the builder constructor
  CustomDatabase.builder(
    this.databaseName,
    this.identitySign,
    this.databaseTableList,
  ); //the database singleton instance

  ///init the database
  void init() async {
    // Avoid errors caused by flutter upgrade.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    _database = await sqlite.openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        (await sqlite.getDatabasesPath()).join("$databaseName.db"),
        onCreate: (Database db, int version) {
      for (var databaseTable in databaseTableList) {
        //get the create table sql
        String createTableSQL = _getCreateTableSQL(databaseTable);
        //execute the sql
        db.execute(createTableSQL);
      }
    });
  }

  ///get the sql to create the table
  ///@param databaseTable : database table object
  ///@return : create table SQL
  String _getCreateTableSQL(DatabaseTable databaseTable) {
    //check the primary key column whether it's exist
    if (databaseTable.dataColumns.containsKey(databaseTable.primaryColumn)) {
      Log.e("primary key column don't exist");
      throw "primary key column don't exist";
    }
    //concat the data to the sql
    else {
      String createTableSQL = "CREATE TABLE ${databaseTable.tableName}( ";
      int cnt = 0;
      for (String columnName in databaseTable.dataColumns.keys) {
        if (columnName == databaseTable.primaryColumn) {
          createTableSQL +=
              ("$columnName ${databaseTable.dataColumns[columnName]!.info} PRIMARY KEY");
        } else {
          createTableSQL += ("$columnName ${databaseTable.dataColumns[columnName]!.info}");
        }
        if (cnt != (databaseTable.dataColumns.length - 1)) {
          createTableSQL += ",";
        }
        cnt++;
      }
      createTableSQL += ")";
      return createTableSQL;
    }
  }

  ///insert the target obj
  ///@param tableName : the target table
  ///@param obj : the insert object
  ///@param conflictAlgorithm : apply algorithm when happen the conflict
  ///@return : the influence rows
  Future<int> insert<E extends Serializable>({
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
  Future<E> findOneById<E extends Serializable>({
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
  ///@param loginUserId : the row information owner id
  ///@param targetObj : target object type
  ///@return : the all result object list
  Future<List<E>> findAll<E extends Serializable>({
    required String tableName,
    String? loginUserId,
    required E targetObj,
  }) async {
    if (ObjectUtil.isEmpty(loginUserId)) {
      List<Map<String, dynamic>> result = await _database!.query(tableName);
      return SerializeUtil.asCustomized(result, targetObj);
    } else {
      List<Map<String, dynamic>> result = await _database!.query(tableName,
          columns: [identitySign], where: "$identitySign=?", whereArgs: [loginUserId]);
      return SerializeUtil.asCustomized(result, targetObj);
    }
  }

  ///update the info by the id
  ///@param tableName : the target table
  ///@param id : the primary key id
  ///@param targetObj : target object type
  ///@return : the influence rows
  Future<int> updateOneById<E extends Serializable>({
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
  Future<bool> isExistById<E extends Serializable>({
    required String tableName,
    required String id,
  }) async {
    List<Map<String, dynamic>> result =
        await _database!.query(tableName, columns: ["id"], where: "id=?", whereArgs: [id]);
    return result.isNotEmpty;
  }

  ///delete the obj by id
  ///@param tableName : the target table
  ///@param id : the primary key id
  ///@return : the influence rows
  Future<int> deleteOneById<E extends Serializable>({
    required String tableName,
    required String id,
  }) {
    return _database!.delete(tableName, where: "id=?", whereArgs: [id]);
  }

  ///you can custom the sql to select data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the result obj list
  Future<List<Map<String, dynamic>>> rawQuery({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawQuery(sql, arguments);
  }

  ///you can custom the sql to select data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the influence rows
  Future<int> rawUpdate({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawUpdate(sql, arguments);
  }

  ///you can custom the sql to insert data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the influence rows
  Future<int> rawInsert({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawInsert(sql, arguments);
  }

  ///you can custom the sql to delete data
  ///@param sql : target sql
  ///@param argument : which will be filled into the sql
  ///@return : the influence rows
  Future<int> rawDelete({
    required String sql,
    List<Object?>? arguments,
  }) {
    return _database!.rawDelete(sql, arguments);
  }
}
