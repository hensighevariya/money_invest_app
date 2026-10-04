import 'dart:async';
import 'package:common_extensions/common_extensions.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/data/model/country_model.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_divider.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/components/no_data_widget.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/utils/validator.dart';

class MobileNumberField extends StatefulWidget {
  final MobileNumberController? controller;
  final String? labelText;
  final String? isoCode;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? mobileFocus;
  final TextStyle? style;
  final bool readOnly;
  final bool prefixEnabled;
  final bool showCountryPicker;
  final bool showCountryCode;
  final bool? isMobileField;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final String? label;
  final String? errorText;
  final Color? labelColor;

  const MobileNumberField({
    this.suffixIcon,
    super.key,
    this.controller,
    this.labelText,
    this.isoCode,
    this.hintText,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.mobileFocus,
    this.onEditingComplete,
    this.style,
    this.onChanged,
    this.readOnly = false,
    this.prefixEnabled = false,
    this.showCountryPicker = true,
    this.showCountryCode = true,
    this.isMobileField,
    this.onTap,
    this.keyboardType,
    this.inputFormatter,
    this.fillColor,
    this.contentPadding,
    this.label,
    this.errorText,
    this.labelColor,
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  late MobileNumberController _controller = widget.controller ?? MobileNumberController();
  late Country _country = _controller.country;
  ValueNotifier<bool?> isEnterDigit = ValueNotifier(null);

  @override
  void didUpdateWidget(covariant MobileNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller = widget.controller ?? MobileNumberController();
      _country = _controller.country;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isEnterDigit,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label ?? '',
                style: context.theme.textTheme.bodyMedium?.copyWith(fontSize: TextSize.label, color: widget.labelColor ?? context.colorScheme.onSurface),
                //overflow: TextOverflow.ellipsis,
              ),
              const Gap(Spacing.medium),
            ],
            CommonTextField(
              onEditingComplete: widget.onEditingComplete,
              onTap: widget.onTap,
              fillColor: widget.fillColor,
              controller: _controller.controller,
              contentPadding: widget.contentPadding,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType ?? TextInputType.emailAddress,
              focusNode: widget.mobileFocus,
              autofocus: false,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: widget.inputFormatter,
              counterText: '',
              errorText: widget.errorText,
              onChanged: (val) {
                if (val.isEmpty) {
                  isEnterDigit.value = null;
                } else {
                  if (!isOnlyDigit(val)) {
                    isEnterDigit.value = false;
                  } else {
                    isEnterDigit.value = true;
                  }
                }
                widget.onChanged?.call(val);
              },
              prefixIcon: widget.isMobileField == null
                  ? isEnterDigit.value == null
                        ? null
                        : isEnterDigit.value ?? false
                        ? FittedBox(
                            child: _CountryPicker(
                              country: _country,
                              onPressed: widget.readOnly
                                  ? () {}
                                  : widget.showCountryPicker
                                  ? showCountryPickerModal
                                  : () {},
                              showCountryCode: widget.showCountryCode,
                            ),
                          )
                        : SvgImageFromAsset.square(SvgIcons.icnEmail, size: 22, color: context.colorScheme.onSurface)
                  : widget.isMobileField ?? false
                  ? FittedBox(
                      child: _CountryPicker(
                        country: _country,
                        onPressed: widget.readOnly
                            ? () {}
                            : widget.showCountryPicker
                            ? showCountryPickerModal
                            : () {},
                        showCountryCode: widget.showCountryCode,
                      ),
                    )
                  : SvgImageFromAsset.square(SvgIcons.icnEmail, size: 22, color: context.colorScheme.onSurface),
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              readOnly: widget.readOnly,
            ),
          ],
        );
      },
    );
  }

  Future<void> showCountryPickerModal() async {
    final country = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.surface,
      elevation: 0,
      builder: (context) =>Container(
        decoration: kIsWeb
            ? BoxDecoration(
          border: Border.all(color: const Color(0xff06090c), width: 0),
          color: context.colorScheme.surface,
        )
            : null,
        child: Container(
          margin: kIsWeb ? const EdgeInsets.all(10.0) : null,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: kIsWeb ? BorderRadius.circular(24) : const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          child: CountryPickerView(onCountrySelected: (country) => context.pop(country)),
        ),
      ),
    );
    if (mounted && country != null) {
      _controller.country = country;
      setState(() => _country = country);
      widget.onChanged?.call(_controller.mobileNumber);
    }
  }
}

class _CountryPicker extends StatelessWidget {
  final Country country;
  final VoidCallback onPressed;
  final bool showCountryCode;

  const _CountryPicker({required this.country, required this.onPressed, required this.showCountryCode});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Row(
        children: [
          Focus(
            canRequestFocus: false,
            descendantsAreFocusable: false,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: PaddingValue.medium,
                child: Row(
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: ShapeBorderRadius.normal,
                      child: CountryPickerHelper.getDefaultFlagImage(country, width: 25, height: 25),
                    ),
                    const Gap(Spacing.medium),
                    if (showCountryCode)
                      Text('+${country.phoneDetail.code}', style: context.theme.textTheme.titleMedium?.copyWith(color: context.colorScheme.onSurface)),
                    const Gap(Spacing.small),
                    SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20, color: colorScheme.onSurface),
                  ],
                ),
              ),
            ),
          ),
          CommonVerticalDivider(height: 20, color: context.colorScheme.onSecondary),
        ],
      ),
    );
  }
}

class MobileNumberController extends ChangeNotifier {
  final TextEditingController controller;
  Country _country;

  MobileNumberController({String? text, String? isoCode, bool iso3Code = true})
    : controller = TextEditingController(text: text),
      _country = iso3Code
          ? CountryPickerHelper.getCountryByIso3Code(isoCode ?? 'KWT') ??
                const Country(
                  isoCode: 'KW',
                  iso3Code: 'KWT',
                  name: 'Kuwait',
                  phoneDetail: (code: '965', maxLength: 8, minLength: 8),
                  translations: {
                    'sk': 'Kuvajt',
                    'se': 'Kuwait',
                    'pl': 'Kuwejt',
                    'no': 'Kuwait',
                    'ja': 'クウェート',
                    'it': 'Kuwait',
                    'zh': '科威特',
                    'nl': 'Koeweit',
                    'de': 'Kuwait',
                    'fr': 'Koweït',
                    'es': 'Kuwait',
                    'en': 'Kuwait',
                    'pt_BR': 'Kuwait',
                    'sr-Cyrl': 'Кувајт',
                    'sr-Latn': 'Kuvajt',
                    'zh_TW': '科威特',
                    'tr': 'Kuveyt',
                    'ro': 'Kuweit',
                    'ar': 'الكويت',
                    'fa': 'کویت',
                    'yue': '科威特',
                    'el': 'Κουβέιτ',
                  },
                )
          : CountryPickerHelper.getCountryByIsoCode(isoCode ?? 'KW') ??
                const Country(
                  isoCode: 'KW',
                  iso3Code: 'KWT',
                  name: 'Kuwait',
                  phoneDetail: (code: '965', maxLength: 8, minLength: 8),
                  translations: {
                    'sk': 'Kuvajt',
                    'se': 'Kuwait',
                    'pl': 'Kuwejt',
                    'no': 'Kuwait',
                    'ja': 'クウェート',
                    'it': 'Kuwait',
                    'zh': '科威特',
                    'nl': 'Koeweit',
                    'de': 'Kuwait',
                    'fr': 'Koweït',
                    'es': 'Kuwait',
                    'en': 'Kuwait',
                    'pt_BR': 'Kuwait',
                    'sr-Cyrl': 'Кувајт',
                    'sr-Latn': 'Kuvajt',
                    'zh_TW': '科威特',
                    'tr': 'Kuveyt',
                    'ro': 'Kuweit',
                    'ar': 'الكويت',
                    'fa': 'کویت',
                    'yue': '科威特',
                    'el': 'Κουβέιτ',
                  },
                );

  Country get country => _country;

  set country(Country value) {
    _country = value;
    notifyListeners();
  }

  String get mobileNumber => controller.text.replaceAll(' ', '');

  String get countryCode => _country.phoneDetail.code;

  void clear() {
    controller.clear();
    country = CountryPickerHelper.getCountryByPhoneCode('1')!;
  }
}

class CountryPickerView extends StatefulWidget {
  final void Function(Country country) onCountrySelected;
  final bool hasCountryCode;

  const CountryPickerView({super.key, required this.onCountrySelected, this.hasCountryCode = true});

  @override
  State<CountryPickerView> createState() => _CountryPickerViewState();
}

class _CountryPickerViewState extends State<CountryPickerView> {
  final List<CountryData> listCountry = [];
  final StreamController<Iterable<Country>> _countryListSubject = StreamController.broadcast();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _countryListSubject.close();
    super.dispose();
  }

  void _onSearchTextChanged(String searchText) {
    var query = searchText.trim().toLowerCase();
    if (query.isEmpty) {
      _countryListSubject.add(countryList);
    } else {
      _countryListSubject.add(_searchCountry(query));
    }
  }

  Iterable<Country> _searchCountry(String query) sync* {
    for (final country in countryList) {
      if (country.name.toLowerCase().contains(query) ||
          country.isoCode.toLowerCase().contains(query) ||
          country.iso3Code.toLowerCase().contains(query) ||
          country.phoneDetail.code.toLowerCase().contains(query) ||
          country.translations.values.any((element) => element.contains(query))) {
        yield country;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingValue.normal,
      child: Column(
        children: [
          CommonTextField(
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            autofocus: true,
            onChanged: _onSearchTextChanged,
            controller: TextEditingController(),
            hintText: context.localizations.searchCountryByNameOrCode,
            // fillColor: context.colorScheme.onPrimary.withValues(alpha: 0.1),
          ),
          const Gap(8),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: StreamBuilder<Iterable<Country>>(
                stream: _countryListSubject.stream,
                initialData: countryList,
                builder: (context, snapshot) {
                  final listCountry = snapshot.data ?? [];
                  return Visibility(
                    visible: listCountry.isNotEmpty,
                    replacement: const Center(child: NoDataWidget()),
                    child: ListView.builder(
                      controller: _scrollController,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: listCountry.length,
                      itemBuilder: (context, index) {
                        final country = listCountry.elementAt(index);
                        return CountryItemView(country: country, onPressed: () => widget.onCountrySelected(country), hasCountryCode: widget.hasCountryCode);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountryItemView extends StatelessWidget {
  final Country country;
  final VoidCallback onPressed;
  final bool hasCountryCode;

  const CountryItemView({super.key, required this.country, required this.onPressed, this.hasCountryCode = true});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return ListTile(
      leading: Material(
        borderRadius: BorderRadius.circular(2),
        clipBehavior: Clip.hardEdge,
        child: CountryPickerHelper.getDefaultFlagImage(country, width: 28, height: 20),
      ),
      visualDensity: VisualDensity.compact,
      title: Text(
        country.translations[locale.languageCode] ?? country.name,
        style: context.theme.textTheme.titleMedium?.copyWith(color: context.colorScheme.onSurface),
      ),
      trailing: hasCountryCode
          ? Text(
              '+${country.phoneDetail.code}',
              style: context.theme.textTheme.titleMedium?.copyWith(fontSize: TextSize.content, color: context.colorScheme.onSurface),
            )
          : null,
      onTap: onPressed,
    );
  }
}
