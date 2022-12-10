import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:skye_utils/configuration/sqlite_configuration.dart';
import 'package:skye_utils/initializer/initializer.dart';
import 'package:skye_utils/util/sqlite/custom_database.dart';

///it's the initializer which is used to initialize the sqlite database
class SqliteInitializer extends Initializer {
  @override
  void init(BuildContext context) {
    //create the database
    CustomDatabase customDatabase = CustomDatabase.builder(
      SqliteConfiguration.DatabaseName,
      SqliteConfiguration.IdentitySign,
      SqliteConfiguration.databaseTableList,
    );
    //init it
    customDatabase.init();
    //put it into the Get container
    Get.put(customDatabase);
  }
}
