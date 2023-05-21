import 'package:flutter/material.dart';
import '../util/color/color_type.dart';

/// ColorInfo which include all color we will use
class ColorInfo {
  ///the adapt color map ,every one should include the light color and dark color
  static const Map<AdaptColorType, Map<ColorEnvironment, Color>> adaptColorMap = {
    AdaptColorType.ThemeColor: {
      ColorEnvironment.Light: Color.fromARGB(255, 48, 135, 191),
      ColorEnvironment.Dark: Color.fromARGB(255, 29, 114, 186),
    },
    AdaptColorType.SecondThemeColor: {
      ColorEnvironment.Light: Color.fromARGB(255, 30, 57, 198),
      ColorEnvironment.Dark: Color.fromARGB(255, 45, 71, 203),
    },
    AdaptColorType.BackgroundColor: {
      ColorEnvironment.Light: Colors.white,
      ColorEnvironment.Dark: Color.fromARGB(255, 52, 52, 52),
    },
    AdaptColorType.PromptColor: {
      ColorEnvironment.Light: Color.fromARGB(255, 59, 59, 59),
      ColorEnvironment.Dark: Color.fromARGB(255, 141, 141, 141),
    },
    AdaptColorType.ForegroundColor: {
      ColorEnvironment.Light: Colors.black54,
      ColorEnvironment.Dark: Colors.white,
    },
    AdaptColorType.FirstTextColor: {
      ColorEnvironment.Light: Colors.black45,
      ColorEnvironment.Dark: Colors.white,
    },
    AdaptColorType.SuccessColor: {
      ColorEnvironment.Light: Color.fromARGB(255, 54, 114, 61),
      ColorEnvironment.Dark: Color.fromARGB(255, 83, 158, 92),
    },
    AdaptColorType.WarningColor: {
      ColorEnvironment.Light: Color.fromARGB(255, 179, 142, 51),
      ColorEnvironment.Dark: Color.fromARGB(255, 212, 169, 12),
    },
    AdaptColorType.ErrorColor: {
      ColorEnvironment.Light: Color.fromARGB(255, 219, 24, 24),
      ColorEnvironment.Dark: Color.fromARGB(255, 217, 7, 24),
    },
  };

  ///the random color list which will be used when we need to get the random color
  static const List<Color> randomColorList = [
    Color.fromARGB(255, 85, 85, 85),
    Color.fromARGB(255, 68, 68, 68),
    Color.fromARGB(255, 51, 51, 51),
    Color.fromARGB(255, 34, 34, 34),
    Color.fromARGB(255, 17, 17, 17),
    Color.fromARGB(255, 238, 0, 0),
    Color.fromARGB(255, 205, 149, 80),
    Color.fromARGB(255, 167, 14, 14),
    Color.fromARGB(255, 128, 9, 9),
    Color.fromARGB(255, 76, 5, 5),
    Color.fromARGB(255, 187, 47, 22),
    Color.fromARGB(255, 212, 89, 23),
    Color.fromARGB(255, 215, 105, 55),
    Color.fromARGB(255, 241, 128, 52),
    Color.fromARGB(255, 226, 155, 13),
    Color.fromARGB(255, 187, 96, 18),
    Color.fromARGB(255, 232, 186, 19),
    Color.fromARGB(255, 180, 145, 14),
    Color.fromARGB(255, 177, 189, 13),
    Color.fromARGB(255, 141, 156, 6),
    Color.fromARGB(255, 121, 146, 32),
    Color.fromARGB(255, 87, 118, 28),
    Color.fromARGB(255, 91, 135, 6),
    Color.fromARGB(255, 66, 147, 23),
    Color.fromARGB(255, 44, 186, 12),
    Color.fromARGB(255, 57, 151, 7),
    Color.fromARGB(255, 45, 172, 50),
    Color.fromARGB(255, 7, 146, 30),
    Color.fromARGB(255, 51, 198, 134),
    Color.fromARGB(255, 35, 156, 118),
    Color.fromARGB(255, 18, 139, 104),
    Color.fromARGB(255, 28, 140, 160),
    Color.fromARGB(255, 31, 155, 173),
    Color.fromARGB(255, 9, 125, 122),
    Color.fromARGB(255, 49, 167, 184),
    Color.fromARGB(255, 55, 120, 177),
    Color.fromARGB(255, 9, 92, 137),
    Color.fromARGB(255, 26, 81, 191),
    Color.fromARGB(255, 48, 99, 201),
    Color.fromARGB(255, 50, 70, 128),
    Color.fromARGB(255, 94, 84, 186),
    Color.fromARGB(255, 143, 116, 205),
    Color.fromARGB(255, 114, 51, 205),
    Color.fromARGB(255, 149, 31, 213),
    Color.fromARGB(255, 166, 84, 210),
    Color.fromARGB(255, 208, 47, 205),
    Color.fromARGB(255, 217, 27, 163),
    Color.fromARGB(255, 201, 95, 199),
    Color.fromARGB(255, 208, 26, 163),
    Color.fromARGB(255, 217, 33, 144),
    Color.fromARGB(255, 134, 70, 111),
    Color.fromARGB(255, 215, 41, 101),
    Color.fromARGB(255, 206, 50, 125),
    Color.fromARGB(255, 212, 23, 77),
    Color.fromARGB(255, 170, 11, 43),
    Color.fromARGB(255, 246, 7, 35),
    Color.fromARGB(255, 108, 6, 19),
    Color.fromARGB(255, 123, 49, 58),
    Color.fromARGB(255, 180, 89, 103),
  ];
}
