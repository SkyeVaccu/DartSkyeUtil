import 'package:flutter/material.dart';

///map extension
extension MapExtension<Q, P> on Map<Q, P> {
  ///traverse the map to create a widget list
  ///Note: you should avoid to use the function to create the listView in the children attribute, it will violate the sliver model ,
  /// it will spend too much time on building widget
  ///@param joinWidget : which will be join between the item
  ///@param startWidget : which will show in the start
  ///@param function : the handle function , it will get the index and the item
  ///@param endWidget : which will show in the end
  ///@return : the widget list which is created by the function
  List<Widget> createWidgetList(
      {Widget? startWidget,
      Widget? joinWidget,
      required Widget Function(Q, P) function,
      Widget? endWidget}) {
    //the widget list which is used to return
    List<Widget> list = [];
    //if the startWidget exist
    if (null != startWidget) {
      list.add(startWidget);
    }
    int index = 0;
    for (var entry in entries) {
      list.add(function.call(entry.key, entry.value));
      //if the join widget isn't null , we will append the joinWidget after the per widget
      if (null != joinWidget && index != (length - 1)) {
        list.add(joinWidget);
      }
      index++;
    }
    //if the endWidget exist
    if (null != endWidget) {
      list.add(endWidget);
    }
    return list;
  }

  ///add all items
  ///@param map : the map which will be appended
  ///@return : the conversion map
  Map<Q, P> merge(Map<Q, P> map) {
    addAll(map);
    return this;
  }

  ///add one item chain
  ///@param iterable : the target item
  ///@return : the conversion map
  Map<Q, P> addItem(Q key, P value) {
    this[key] = value;
    return this;
  }
}
