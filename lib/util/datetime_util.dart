import 'package:date_format/date_format.dart' as DateFormat;
import 'package:skye_utils/util/string_util.dart';

///it's used to operate the datetime
class DatetimeUtil {
  ///get the current time
  ///@return : the current datetime
  static DateTime now() => DateTime.now();

  ///get the timeStamp of current date
  ///@return : the timestamp of current date time
  static int nowTimeStamp() => DateTime.now().millisecondsSinceEpoch;

  ///return the DateTime assigned to the timeStamp
  ///@param timeStamp : the milliseconds
  ///@return : the assigned DateTime object
  static DateTime fromTimeStamp(int timeStamp) => DateTime.fromMillisecondsSinceEpoch(timeStamp);

  ///convert the dateTime String to DateTime object , it can be converted many formats
  ///@param datetimeString : the datetime String
  ///@return : the DateTime obj
  static DateTime convertStringToDate(String datetimeString) => DateTime.parse(datetimeString);

  ///convert the dateTime object to date string
  ///@param dateTime : the dateTime object
  ///@param formatString : the date format string
  ///@return : the conversion string
  static String convertDateToString(DateTime dateTime, String formatString) {
    return DateFormat.formatDate(dateTime, StringUtil.splitAndKeepJoin(formatString, "[^a-zA-Z]"));
  }
}
