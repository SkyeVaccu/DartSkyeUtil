import 'dart:ui';

import 'package:flutter/material.dart';

///it's the util to provide some convenient widget
class WidgetUtil {
  ///convert the widget to a Gauss background widget
  ///@return : the widget with Gauss background
  static Widget convertToGaussBlurWidget(
    Widget widget, {
    double sigmaX = 10,
    double sigmaY = 10,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: widget,
    );
  }

  /// convert the widget to a widget with the shadow
  /// @return : the converted widget
  static Widget convertToShadowWidget(
    Widget widget, {
    Color? color,
    double xOffset = 5,
    double yOffset = 5,
    double blurRadius = 10,
    double spreadRadius = 0,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: color ?? Colors.grey,
          offset: Offset(xOffset, yOffset),
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        )
      ]),
      child: widget,
    );
  }
}
