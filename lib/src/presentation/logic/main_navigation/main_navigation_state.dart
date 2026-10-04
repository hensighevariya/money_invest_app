import 'package:equatable/equatable.dart';

enum MainNavDestination { home, shorts, watchList, profile }

class MainNavigationState extends Equatable {
  final MainNavDestination destination;

  const MainNavigationState({required this.destination});

  @override
  List<Object?> get props => [destination];
}
