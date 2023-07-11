import 'package:flutter/material.dart';

import '../../util/object_util.dart';

/// it's the class_extension of the widget
extension WidgetExtension on Widget {
  ///handle the situation when the state is null
  ///@param state : judge state
  ///@param handleDefaultValue : whether it need to handle the default value
  ///@param width : the blank sized box width
  ///@param height : the blank sized box height
  ///@return : the result widget
  Widget handleStateNull(
    dynamic state, {
    bool handleDefaultValue = false,
    double? width,
    double? height,
  }) {
    late SizedBox sizedBox;
    //if the user set the width and the height ,we will use it
    if (width != null && height != null) {
      sizedBox = SizedBox(
        width: width,
        height: height,
      );
    } else {
      sizedBox = const SizedBox();
    }
    //handle the state
    if (state == null) {
      return sizedBox;
    } else if (state is bool && !state) {
      return sizedBox;
    } else if (handleDefaultValue && ObjectUtil.isDefaultValue(state)) {
      return sizedBox;
    }
    return this;
  }
}
