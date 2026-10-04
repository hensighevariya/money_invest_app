import 'package:country_picker/src/country_model.dart';
import 'package:equatable/equatable.dart';

abstract class CountryPickerState extends Equatable {
  const CountryPickerState();

  @override
  List<Object?> get props => [];
}

class EmptyState extends CountryPickerState {
  const EmptyState();
}

class ResultState extends CountryPickerState {
  final String query;
  final List<Country> listCountry;

  const ResultState(this.listCountry, {this.query = ""});

  @override
  List<Object?> get props => [listCountry, query];
}
