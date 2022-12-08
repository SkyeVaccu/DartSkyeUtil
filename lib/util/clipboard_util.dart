import 'package:flutter/services.dart';

/// clipboard util, you can use it to operate the clipboard
class ClipboardUtil {
  ///write the string into the clipboard
  ///@param data : the data  which will be written into the clipboard
  static void put(String data) {
    Clipboard.setData(ClipboardData(text: data));
  }

  ///read the data from Clipboard
  ///@return: the lastest string in the clipboard
  static Future<String?> get() async {
    return (await Clipboard.getData(Clipboard.kTextPlain))?.text;
  }
}
