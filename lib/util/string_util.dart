import 'dart:math';

import 'package:uuid/uuid.dart';

///the util to operate the string
class StringUtil {
  ///create a UUID
  ///@return : the UUID string
  static String getUUID() => const Uuid().v1();

  ///split the string and keep the matched substring
  ///@param str : the origin string
  ///@param reg : the regular expression
  ///@return : the result list which include the split char
  static List<String> splitAndKeepJoin(String str, String reg) {
    //the regular expression
    Pattern pattern = RegExp(reg);
    //the match substring of the String
    List<String> matchList = [];
    Iterable<Match> iterable = pattern.allMatches(str);
    for (var element in iterable) {
      matchList.add(element.group(0) ?? "");
    }
    //the non-match substring of the string
    List<String> nonMatchList = str.split(pattern);
    //join the match list and the non-match list
    List<String> result = [];
    int i;
    for (i = 0; i < min(nonMatchList.length, matchList.length); i++) {
      if (nonMatchList[i] != "") {
        result.add(nonMatchList[i]);
      }
      result.add(matchList[i]);
    }
    //add the rest string
    if (nonMatchList.length < matchList.length) {
      result.addAll(matchList.sublist(i));
    } else {
      nonMatchList.sublist(i).forEach((element) {
        if (element != "") {
          result.add(element);
        }
      });
    }
    return result;
  }
}
