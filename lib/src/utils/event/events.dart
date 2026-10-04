import 'package:equatable/equatable.dart';

class EventName extends Equatable {
  const EventName(this.points);

  final int points;

  @override
  List<Object?> get props => [points];
}
