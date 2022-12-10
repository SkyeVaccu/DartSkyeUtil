import 'package:skye_utils/initializer/service/http_initializer.dart';
import 'package:skye_utils/initializer/initializer.dart';
import 'package:skye_utils/initializer/service/sqlite_initializer.dart';
import 'package:skye_utils/initializer/ui/status_bar_initializer.dart';
import 'package:skye_utils/initializer/service/websocket_initializer.dart';

///it's the configuration to configure all initializer
class InitializerConfiguration {
  // the initializer list
  static final List<Initializer> initializerList = [
    HttpInitializer(),
    WebSocketInitializer(),
    SqliteInitializer(),
    StatusBarInitializer(),
  ];
}
