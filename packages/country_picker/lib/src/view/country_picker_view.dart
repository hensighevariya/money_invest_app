import 'package:country_picker/src/country_model.dart';
import 'package:country_picker/src/helpers.dart';
import 'package:country_picker/src/view/country_picker_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_picker_bloc.dart';
import 'country_picker_state.dart';

class CountryPickerView extends StatelessWidget {
  const CountryPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            width: 64,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.inverseSurface.withAlpha(50),
            ),
          ),
        ),
        SafeArea(
          top: false,
          bottom: false,
          minimum: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SearchField(
            onChanged:
                (value) => context.read<CountryPickerBloc>().add(
                  SearchCountry(query: value),
                ),
            onSubmitted:
                (value) => context.read<CountryPickerBloc>().add(
                  SearchCountry(query: value),
                ),
          ),
        ),
        Expanded(
          child: BlocBuilder<CountryPickerBloc, CountryPickerState>(
            builder: (context, state) {
              if (state is ResultState) {
                return CountryList(
                  listCountry: state.listCountry,
                  onCountrySelected:
                      (country) => Navigator.of(context).pop(country),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const SearchField({super.key, this.onChanged, this.onSubmitted});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _controller,
      autofocus: true,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      autofillHints: const [
        AutofillHints.countryCode,
        AutofillHints.countryName,
        AutofillHints.telephoneNumberCountryCode,
      ],
      decoration: InputDecoration(
        fillColor: colorScheme.surface,
        filled: true,
        hintText: MaterialLocalizations.of(context).searchFieldLabel,
        suffixIcon: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Visibility(
              visible: _controller.text.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  _controller.clear();
                  widget.onChanged?.call("");
                },
                visualDensity: VisualDensity.compact,
                enableFeedback: true,
                splashRadius: 20,
                icon: const Icon(Icons.close),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CountryList extends StatelessWidget {
  final Iterable<Country> listCountry;
  final void Function(Country country) onCountrySelected;

  const CountryList({
    super.key,
    required this.listCountry,
    required this.onCountrySelected,
  });

  Widget? _itemBuilder(BuildContext context, int index) {
    var country = listCountry.elementAt(index);
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context);

    return ListTile(
      leading: Material(
        borderRadius: BorderRadius.circular(2),
        clipBehavior: Clip.hardEdge,
        child: CountryPickerHelper.getDefaultFlagImage(
          country,
          width: 32,
          height: 24,
        ),
      ),
      visualDensity: VisualDensity.compact,
      leadingAndTrailingTextStyle: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: Text(
        "${country.translations[locale.languageCode] ?? country.name} (${country.isoCode})",
      ),
      trailing: Text("+${country.phoneDetail.code}"),
      onTap: () => onCountrySelected(country),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        primary: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverSafeArea(
            left: false,
            right: false,
            minimum: const EdgeInsets.symmetric(vertical: 8),
            sliver: SliverList.builder(
              itemBuilder: _itemBuilder,
              itemCount: listCountry.length,
            ),
          ),
        ],
      ),
    );
  }
}
