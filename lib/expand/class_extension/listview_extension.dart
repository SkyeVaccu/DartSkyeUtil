import 'dart:io';

import 'package:flutter/material.dart';

///the ListView class_extension
extension ListViewExtension on ListView {
  ///remove the listview overScroll effect which will create the bad influence
  ///@return : the list without the overscroll effect
  ScrollConfiguration removeWaveEffects() {
    return ScrollConfiguration(
      //use the customized behavior
      behavior: _CusBehavior(controller),
      child: this,
    );
  }
}

///the customized scroll behavior which is used to cancel scroll behavior
class _CusBehavior extends ScrollBehavior {
  final ScrollController? scrollController;

  const _CusBehavior(this.scrollController);

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    //android and fuchsia don't have the overscroll affection
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    }
    return super.buildOverscrollIndicator(
      context,
      child,
      ScrollableDetails(
        direction: axisDirection,
        controller: scrollController ?? ScrollController(),
      ),
    );
  }
}
