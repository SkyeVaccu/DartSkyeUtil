import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' as RootBundle;

///asset util, you can get the
class AssetUtil {
  ///get the asset string from the asset file
  ///@param fileName: the name of the asset file
  ///@return : the string content of the asset file
  static Future<String> readDataFile(String fileName) {
    //read the file content as String
    return RootBundle.rootBundle.loadString(fileName);
  }

  ///get the assetImage in the asset image
  ///@param fileName: the name of asset image file
  ///@return : the asset image object
  static AssetImage readDataImage(String fileName) {
    return AssetImage(fileName);
  }
}
