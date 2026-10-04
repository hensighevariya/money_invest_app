import 'dart:async';

mixin StreamSubscriptionMixin {
  final List<StreamSubscription<Object?>> _subscriptions = [];

  void addSubscription(StreamSubscription<Object?> subscription) {
    _subscriptions.add(subscription);
  }

  void addAllSubscriptions(List<StreamSubscription<Object?>> subscriptions) {
    _subscriptions.addAll(subscriptions);
  }

  void cancelAllSubscriptions() {
    if (_subscriptions.isEmpty) return;
    for (final element in _subscriptions) {
      element.cancel();
    }
  }
}
