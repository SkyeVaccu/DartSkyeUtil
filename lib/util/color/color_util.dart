import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skye_utils/standard/color_info.dart';
import 'package:skye_utils/util/color/color_type.dart';
import 'package:skye_utils/util/number_util.dart';

///the util is used to get the correct color
class ColorUtil {
  ///get the adapt in the different theme mode
  ///you can reverse the color which is set
  ///@param adaptColorType : the adapted color type
  ///@param reverse : check the color in the another environment
  ///@return : the result Color
  static Color getAdaptColor(AdaptColorType adaptColorType, {bool reverse = false}) {
    //get the corresponding color map
    var adaptColor = ColorInfo.adaptColorMap[adaptColorType];
    //return the true color
    return Get.isDarkMode ^ reverse
        ? adaptColor![ColorEnvironment.Dark]!
        : adaptColor![ColorEnvironment.Light]!;
  }

  ///the theme data which is used in the light mode
  ///@param isDark : whether it's dark
  ///@return : the theme data
  static ThemeData getThemeData({bool isDark = false}) {
    if (!isDark) {
      return ThemeData(
        brightness: Brightness.light,
        primarySwatch: ColorUtil.createMaterialColor(
          ColorInfo.adaptColorMap[AdaptColorType.ThemeColor]![ColorEnvironment.Light]!,
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.dark,
        primarySwatch: ColorUtil.createMaterialColor(
            ColorInfo.adaptColorMap[AdaptColorType.ThemeColor]![ColorEnvironment.Dark]!),
      );
    }
  }

  /// get the random color
  /// @return : the result color
  static Color getRandomColor() {
    //get the deep color list
    var deepColorList = ColorInfo.randomColorList;
    //return the random deep color
    return deepColorList[NumberUtil.createRandomNumber(ceil: deepColorList.length)];
  }

  ///create the material color by the color
  ///@param color : the main color
  ///@return : the material color in the different depth
  static MaterialColor createMaterialColor(Color color) {
    //set the offset
    List strengths = [0.05, 0.1, 0.2, 0.3, 0.35, 0.4, 0.5, 0.6, 0.7, 0.8, 0.85, 0.9];
    //set the map
    Map<int, Color> swatch = {};
    //get the red green blue
    final int r = color.red, g = color.green, b = color.blue;
    //create the swatch color
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
