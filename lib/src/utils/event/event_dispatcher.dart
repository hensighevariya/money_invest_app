import 'dart:async';

class EventDispatcher {
  EventDispatcher._private(this._controller);

  factory EventDispatcher.createInstance([StreamController<Object?>? controller]) {
    return EventDispatcher._private(controller ?? StreamController.broadcast());
  }

  static EventDispatcher get instance => _instance ??= EventDispatcher.createInstance();
  static EventDispatcher? _instance;

  final StreamController<Object?> _controller;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return _controller.stream as Stream<T>;
    } else {
      return _controller.stream.where((event) => event is T).cast<T>();
    }
  }

  void dispatch<T>(T event) {
    _controller.add(event);
  }
}
