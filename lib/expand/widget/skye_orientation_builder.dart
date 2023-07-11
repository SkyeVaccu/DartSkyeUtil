import 'package:flutter/material.dart';

/// a Orientation Builder which the use method like the OrientationLayoutBuilder
class SkyeOrientationBuilder extends StatelessWidget {
  //the function which is used when the device is portrait
  final Widget Function(BuildContext) portrait;
  //the function which is used when the device is landscape
  final Widget Function(BuildContext)? landscape;

  const SkyeOrientationBuilder({Key? key, required this.portrait, this.landscape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      //judge the state and call the corresponding method
      if (orientation == Orientation.landscape && landscape != null) {
        return landscape!.call(context);
      } else {
        return portrait.call(context);
      }
    });
  }
}
