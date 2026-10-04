import 'package:flutter/foundation.dart';

import 'main_navigation_state.dart';

@immutable
sealed class MainNavigationEvent {
  const MainNavigationEvent();
}

class MainNavigationDestinationChanged extends MainNavigationEvent {
  const MainNavigationDestinationChanged(this.destination);

  final MainNavDestination destination;
}
