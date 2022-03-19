import 'package:event_bus/event_bus.dart';

EventBus appEvenBus = EventBus();

class BusEvent {
    EventType eventType;
    Map<String, dynamic> extraInfo;

    BusEvent({this.eventType = EventType.busEvent, this.extraInfo = const {}});
}

enum EventType {
    busEvent,
}