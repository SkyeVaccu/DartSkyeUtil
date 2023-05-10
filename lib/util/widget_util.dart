import 'dart:ui';

import 'package:flutter/material.dart';

///it's the util to provide some convenient widget
class WidgetUtil {
  ///convert the widget to a Gauss background widget
  ///@return : the widget with Gauss background
  static Widget convertToGaussBlurWidget(Widget widget, {double sigmaX = 10, double sigmaY = 10}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: widget,
    );
  }
}
