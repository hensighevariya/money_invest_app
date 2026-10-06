import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/country_model.dart';
import 'src/view/country_picker_bloc.dart';
import 'src/view/country_picker_view.dart';

export 'src/country_list.dart';
export 'src/country_model.dart';
export 'src/helpers.dart';

Future<Country?> showCountryPicker({required BuildContext context}) {
  final mediaQuery = MediaQueryData.fromView(View.of(context));
  final colorScheme = Theme.of(context).colorScheme;
  return showModalBottomSheet<Country>(
    context: context,
    builder:
        (context) => BlocProvider(
          create: (context) => CountryPickerBloc(),
          child: const CountryPickerView(),
        ),
    backgroundColor: colorScheme.surface,
    constraints: BoxConstraints(
      maxHeight: mediaQuery.size.height - mediaQuery.padding.top - 8,
    ),
    routeSettings: const RouteSettings(name: "/country_picker"),
    isScrollControlled: true,
  );
}
