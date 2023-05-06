import 'package:event_bus/event_bus.dart';
import '../../util/event_bus/bus_event.dart';
import '../../util/event_bus/bus_event_type.dart';

///event bus class which is used to do some operation across uncorrelated page
class EventBusUtil {
  //the singleton instance
  static EventBus? _instance;

  ///get th unique eventBus instance
  ///@return : the eventBus singleton instance
  static EventBus _getInstance() {
    return _instance ??= EventBus();
  }

  ///send an busEvent into the bus
  ///@param busEvent : the bus event
  static void send(BusEvent busEvent) {
    _getInstance().fire(busEvent);
  }

  ///add the listener into bus event ,you should judge the bus event type
  ///@param onData : listen function when you receive the bus event
  ///@param busEventType : handle busEventType
  ///@parma onError : listen the error when the bus event is error
  ///@param onDone : it will be executed when the listener is done
  ///@param cancelOnError : whether cancel the listener when the error happen
  static void listen(void Function(BusEvent event)? onData, BusEventType busEventType,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    //add the listener
    _getInstance().on<BusEvent>().listen((BusEvent event) {
      if (event.busEventType == busEventType) {
        onData?.call(event);
      }
    }, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
