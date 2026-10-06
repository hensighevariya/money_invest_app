import 'dart:async';

import 'package:country_picker/src/country_list.dart';
import 'package:country_picker/src/country_model.dart';
import 'package:country_picker/src/view/country_picker_event.dart';
import 'package:country_picker/src/view/country_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

class CountryPickerBloc extends Bloc<CountryPickerEvent, CountryPickerState> {
  CountryPickerBloc() : super(const ResultState(countryList)) {
    on<SearchCountry>(
      _onSearchCountry,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  FutureOr<void> _onSearchCountry(
    SearchCountry event,
    Emitter<CountryPickerState> emit,
  ) async {
    var state = this.state;
    if (state is ResultState && state.query == event.query) return;
    var query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(const ResultState(countryList));
    } else {
      final listCountry = _searchCountry(query);
      if (listCountry.isEmpty) {
        emit(const EmptyState());
      } else {
        emit(ResultState(listCountry.toList(), query: query));
      }
    }
  }

  Iterable<Country> _searchCountry(String query) sync* {
    for (var country in countryList) {
      if (country.name.toLowerCase().contains(query) ||
          country.isoCode.toLowerCase().contains(query) ||
          country.iso3Code.toLowerCase().contains(query) ||
          country.phoneDetail.code.toLowerCase().contains(query) ||
          country.translations.values.any(
            (element) => element.contains(query),
          )) {
        yield country;
      }
    }
  }
}
