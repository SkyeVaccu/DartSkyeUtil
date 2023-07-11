import 'bus_event_type.dart';

///which is take in the event_bus
class BusEvent {
  //the type of the bus event
  BusEventType busEventType = BusEventType.Default;

  //the content in the bus event
  dynamic content;

  //the create time
  late DateTime createTime;

  BusEvent(this.busEventType, this.content) {
    createTime = DateTime.now();
  }
}
