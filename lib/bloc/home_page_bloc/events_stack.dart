import 'package:benayty/bloc/home_page_bloc/bloc.dart';

class EventsStack {
  static List<HomePageEvent> _eventsStack = List();

  static push(HomePageEvent event) {
    _eventsStack.add(event);
  }

  static HomePageEvent pop() {
    HomePageEvent event = _eventsStack.last;
    if (_eventsStack.length > 0) _eventsStack.removeLast();
    return event;
  }

  static clear() {
    while (_eventsStack.length > 0) {
      _eventsStack.removeLast();
    }
  }

  static HomePageEvent top() {
    return _eventsStack.last;
  }
}
