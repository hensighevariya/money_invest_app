import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_navigation_event.dart';
import 'main_navigation_state.dart';

class MainNavigationBloc
    extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc()
    : super(const MainNavigationState(destination: MainNavDestination.home)) {
    on<MainNavigationDestinationChanged>(_onDestinationChanged);
  }

  void _onDestinationChanged(
    MainNavigationDestinationChanged event,
    Emitter<MainNavigationState> emit,
  ) {
    emit(MainNavigationState(destination: event.destination));
  }
}
