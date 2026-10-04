import 'package:equatable/equatable.dart';

abstract class CountryPickerEvent extends Equatable {
  const CountryPickerEvent();

  @override
  List<Object?> get props => [];
}

class SearchCountry extends CountryPickerEvent {
  final String query;

  const SearchCountry({required this.query});

  @override
  List<Object?> get props => [query];
}
