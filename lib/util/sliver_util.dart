import 'package:flutter/material.dart';

///it's the util to handle the sliver
class SliverUtil {
  ///remove the top padding, you should give the context object,
  /// it will just adjust the sub tree to upgrade performance
  ///@return : the listview without the blank area
  static MediaQuery removeTop(ListView listView, BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: listView,
      removeTop: true,
    );
  }
}
