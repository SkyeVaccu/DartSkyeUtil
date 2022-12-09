import 'package:flutter/material.dart';

///list extension
extension ListExtension<E> on List<E> {
  ///create the list which filled with the widget by the input function
  ///Note: you should avoid to use the function to create the listView in the children attribute, it will violate the sliver model ,
  /// it will spend too much time on building widget
  ///@param joinWidget : which will be join between the item
  ///@param startWidget : which will show in the start
  ///@param function : the handle function , it will get the index and the item
  ///@param endWidget : which will show in the end
  ///@return : the widget list which is created by the function
  List<Widget> createWidgetList(
      { Widget? startWidget,
        Widget? joinWidget,
        required Widget Function(int, E) function,
        Widget? endWidget}) {
    //the list which is used to return
    List<Widget> list = [];
    //if the startWidget exist
    if (null != startWidget) {
      list.add(startWidget);
    }
    for (var index = 0; index < this.length; index++) {
      list.add(function.call(index, this[index]));
      //if the joinWidget isn't null , append it into after per widget. it won't shown after the last widget
      if (null != joinWidget && index!= (this.length-1)) {
        list.add(joinWidget);
      }
    }
    //if the endWidget exist
    if (null != endWidget) {
      list.add(endWidget);
    }
    return list;
  }

  ///append the item at the first of the list
  ///@param item : the target item
  ///@return : the conversion list
  List<E> addFirst(E item) {
    //create a list
    var list = [item];
    //append all items
    list.addAll(this);
    //return the list
    return list;
  }

  ///a addAll chain method
  ///@param iterable : the list which will be appended
  ///@return : the conversion list
  List<E> merge(Iterable<E> iterable) {
    this.addAll(iterable);
    return this;
  }

  ///a add chain method
  ///@param iterable : the target item
  ///@return : the conversion list
  List<E> addItem(E item) {
    this.add(item);
    return this;
  }

  ///this extension method is used to complete the chain operation easily,
  ///you can operate the list in the function. if you return nothing ,then it will return the list ,
  ///otherwise it will use the return value
  ///@param operateFunction : the handle function
  ///@return : the handled list
  List<E> chainOperate(List<E> Function(List<E>) operateFunction) {
    return operateFunction.call(this);
  }

  ///merge all list items to the last list , it like the flatMap operation
  ///convert the List<List> to List<>
  ///@return : the paving list
  List<E> flatMapToList() {
    List<E> result = [];
    for (var value in this) {
      if (value is List<E>) {
        result.addAll(value);
      }
    }
    return result;
  }

  ///merge all list items to the last map , convert the List<Map> to Map<>
  ///@return : the paving map
  Map<Q, P> flatMapToMap<Q, P>() {
    Map<Q, P> result = {};
    for (var value in this) {
      if (value is Map<Q, P>) {
        result.addAll(value);
      }
    }
    return result;
  }
}
