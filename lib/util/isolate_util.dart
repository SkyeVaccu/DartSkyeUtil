import 'dart:async';

import 'package:flutter/foundation.dart';

///it's used to create task to apply in the new thread
class IsolateUtil {
  ///create a isolateRunnerBuilder
  ///@param function : the execution function
  ///@return : _IsolateRunnerBuilder object
  static _IsolateRunnerBuilder builder(Function function) {
    return new _IsolateRunnerBuilder(function);
  }
}

/// to build a builder to allow run the task in the another thread
class _IsolateRunnerBuilder {
  //the target function
  Function function;

  //the index of the parameter
  int parameterIndex = 0;

  //list store all parameters
  List<dynamic> parameterList = [];

  ///the constructor function
  _IsolateRunnerBuilder(this.function);

  ///set the parameter of the function
  ///@param parameter : the method parameter
  ///@return : the builder object
  _IsolateRunnerBuilder setParameter(dynamic parameter) {
    //put the parameter
    parameterList.add(parameter);
    return this;
  }

  ///run the function
  ///@return : the return value
  FutureOr<dynamic> run() {
    return compute(this.function as FutureOr<dynamic> Function(List<dynamic>), parameterList);
  }
}
