import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../configuration/auto_configuration/sqlite_configuration.dart';
import '../../initializer/initializer.dart';
import '../../system/yaml/yaml_configuration.dart';
import '../../system/yaml/yaml_parser.dart';
import '../../util/cache_util.dart';
import '../../util/sqlite/custom_database.dart';
import '../initializer_enhance.dart';

///it's the initializer which is used to initialize the sqlite database
class SqliteInitializer extends Initializer with InitializerEnhance {
  @override
  Future<void> init(BuildContext context) async {
    // if we active the sqlite environment
    if (openConfiguration("sqlite.status")) {
      //parse the sqlite table yaml
      YamlConfiguration sqliteConfiguration = await YamlParser.parse("resource/sqlite_table.yaml");
      // store the sqlite table configuration into the global cache
      CacheUtil.put("_SqliteTableConfiguration", sqliteConfiguration);
      // get the instance
      SqliteConfiguration instance = SqliteConfiguration.getInstance();
      //create the database
      CustomDatabase customDatabase = CustomDatabase.builder(
        instance.dataBaseName,
        instance.identitySign,
        instance.databaseTableList,
      );
      //init it
      customDatabase.init();
      //put it into the Get container
      Get.put(customDatabase);
    }
  }
}
