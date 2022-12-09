import 'dart:ui';

import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  ///handle the situation when the state is null
  Widget handleStateNull(
    dynamic state, {
    bool handleZero = false,
    double? width,
    double? height,
  }) {
    SizedBox sizedBox = SizedBox();
    //if the user set the width and the height ,we will use it
    if (width != null && height != null) {
      sizedBox = SizedBox(
        width: width,
        height: height,
      );
    }
    if (state == null) {
      return sizedBox;
    } else if (state is bool) {
      if (!state) {
        return sizedBox;
      }
    } else if (handleZero) {
      if ((state as int) == 0) {
        return sizedBox;
      }
    }
    return this;
  }

  ///convert the widget to a Gauss background widget
  Widget convertToGaussBlurWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: this,
    );
  }

  ///make the wight float in the center of the stack
  ///the default layout size is the vertical margin and the horizontal margin both are 30
  Widget toFloatInCenter({
    bool vertical = true,
    bool horizontal = true,
    double verticalMargin = 30,
    double horizontalMargin = 30,
  }) {
    return Positioned(
      top: vertical ? verticalMargin : null,
      bottom: vertical ? verticalMargin : null,
      left: horizontal ? horizontalMargin : null,
      right: horizontal ? horizontalMargin : null,
      child: this,
    );
  }
}
