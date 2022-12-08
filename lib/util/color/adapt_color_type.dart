/// the all type of the customized adapt color
enum AdaptColorType {
  /// the main theme color in the application
  ThemeColor,

  /// the background color in the application
  BackgroundColor,

  /// the foreground color in the application
  ForegroundColor,

  /// the first text color in the application
  FirstTextColor,

  /// the second text color in the application
  SecondTextColor,

  /// the foreground text color in the application
  ForegroundTextColor,
}

// /// the extension of the type
// extension AdaptColorTypeExtension on AdaptColorType {
//   //the info which is included into the type
//   String get info => [
//         "ThemeColor",
//         "BackgroundColor",
//         "ForegroundColor",
//         "FirstTextColor",
//         "SecondTextColor",
//         "ForegroundTextColor",
//       ][index];
// }

///the color environment
enum ColorEnvironment {
  //the light situation
  Light,
  //the dark situation
  Dark,
}

// /// the extension of the type
// extension ColorEnvironmentExtension on ColorEnvironment {
//   //the info which is included into the type
//   String get info => [
//         "Light",
//         "Dark",
//       ][index];
// }
