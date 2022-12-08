import 'dart:async';

///the timer util to create the timer task
class TimerUtil {
  /// execute the task and delay it for some seconds
  /// @param delaySeconds : the delay time
  /// @param function : the target function
  static void delayExecuteTask(int delaySeconds, void Function() function) {
    Future.delayed(Duration(seconds: delaySeconds), function);
  }

  ///execute the task in period
  ///@param interval : the interval time
  ///@param function : the execution function
  ///@param count : the execution time
  ///@param delaySeconds : the delay time at the first execution
  static void periodExecuteTask(
      {required int intervalSeconds,
      required void Function(Timer) function,
      int count = 3,
      int delaySeconds = 0}) {
    //the count time
    int cnt = 0;
    //submit time to execute in period
    Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      //execute the task by delaying some time
      if (cnt == 0) {
        Future.delayed(Duration(seconds: delaySeconds), () {
          function.call(timer);
          cnt++;
        });
      } else {
        if (cnt != count) {
          function.call(timer);
          cnt++;
        }
        //call the function
        else {
          timer.cancel();
        }
      }
    });
  }
}
