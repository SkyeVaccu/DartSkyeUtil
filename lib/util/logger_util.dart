import 'package:logger/logger.dart';

///this is a log util which is used to print the log，it will print the log information with the author name
///you can choose to print the information with the stack info or not
///Note : we notice that we should not to print the stack method info into the console , because it's the duty of the exception.
///log should only have the message which we want to obey.
class Log {
  ///the map stores all the authorName and the logger,
  ///the key is the author name , the value is the logger object
  static Map<String, Logger> _loggerMap = {};

  ///get the corresponding logger by the author name
  ///@param authorName : the developer name
  ///@param stackMethodCount : the stack method count which will be shown in the console
  ///@return : the logger printer
  static Logger getInstance({String authorName = "Skye", int stackMethodCount = 1}) {
    return _loggerMap[authorName] ??=
        Logger(printer: new PrettyPrinter(methodCount: stackMethodCount));
  }

  ///print the info log
  ///@param message : the message what will be shown in the console
  ///@param authorName : the developer name
  static void i(String message, {String authorName = "Skye"}) {
    var logger = getInstance(authorName: authorName);
    logger.i(authorName + ":" + message);
  }

  ///print the debug log
  ///@param message : the message what will be shown in the console
  ///@param authorName : the developer name
  static void d(String message, {String authorName = "Skye"}) {
    var logger = getInstance(authorName: authorName);
    logger.i(authorName + ":" + message);
  }

  ///print the warning log
  ///@param message : the message what will be shown in the console
  ///@param authorName : the developer name
  static void w(String message, {String authorName = "Skye"}) {
    var logger = getInstance(authorName: authorName);
    logger.w(authorName + ":" + message);
  }

  ///print the error log
  ///@param message : the message what will be shown in the console
  ///@param authorName : the developer name
  static void e(String message, {String authorName = "Skye", dynamic error}) {
    var logger = getInstance(authorName: authorName);
    logger.e(authorName + ":" + message, error);
  }
}
