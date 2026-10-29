import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/alert_message.dart';
import 'package:money_invest_app/src/presentation/components/location_picker_bottom_sheet.dart';
import 'package:money_invest_app/src/presentation/presentation.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _cachedAddress;

  @override
  void initState() {
    super.initState();
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _cachedAddress = userRepo.getAddress();
    context.read<UserProfileBloc>().add(const FetchUserProfile());
  }

  void _showEditFieldSheet({
    required String title,
    required String initialValue,
    required String label,
    required TextInputType keyboardType,
    required void Function(String value) onSave,
    int maxLines = 1,
  }) {
    final controller = TextEditingController(text: initialValue);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF1C202C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.of(sheetContext).pop(),
                  ),
                ],
              ),
              const Gap(16),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                maxLines: maxLines,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(color: Color(0xFF8E95A5)),
                  filled: true,
                  fillColor: const Color(0xFF12151D),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF2E3548)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF547AFF)),
                  ),
                ),
              ),
              const Gap(20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E73F8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    onSave(text);
                    Navigator.of(sheetContext).pop();
                    showSuccessMessage(
                      context: context,
                      content: '$title updated successfully!',
                    );
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    );
  }

  void _showEditNameSheet({
    required String currentFirstName,
    required String currentLastName,
  }) {
    final firstNameController = TextEditingController(text: currentFirstName);
    final lastNameController = TextEditingController(text: currentLastName);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF1C202C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Update Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.of(sheetContext).pop(),
                    ),
                  ],
                ),
                const Gap(16),
                TextField(
                  controller: firstNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: const TextStyle(color: Color(0xFF8E95A5)),
                    filled: true,
                    fillColor: const Color(0xFF12151D),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF2E3548)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF547AFF)),
                    ),
                  ),
                ),
                const Gap(16),
                TextField(
                  controller: lastNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: const TextStyle(color: Color(0xFF8E95A5)),
                    filled: true,
                    fillColor: const Color(0xFF12151D),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF2E3548)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF547AFF)),
                    ),
                  ),
                ),
                const Gap(24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E73F8),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final fName = firstNameController.text.trim();
                    final lName = lastNameController.text.trim();
                    if (fName.isNotEmpty) {
                      context.read<UserProfileBloc>().add(
                            UpdateUserProfile(
                              firstName: fName,
                              lastName: lName,
                            ),
                          );
                      Navigator.of(sheetContext).pop();
                      showSuccessMessage(
                        context: context,
                        content: 'Name updated successfully!',
                      );
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditAddressSheet({
    required String initialAddress,
    required String initialPincode,
    String? initialCountryId,
    String? initialCountryName,
    String? initialStateId,
    String? initialStateName,
    String? initialCityId,
    String? initialCityName,
  }) {
    final addressController = TextEditingController(text: initialAddress);
    final pincodeController = TextEditingController(text: initialPincode);
    final authRepo = RepositoryProvider.of<AuthRepository>(context);

    List<LocationCountry> countries = [];
    List<LocationState> states = [];
    List<LocationCity> cities = [];
    String? selectedCountryId = initialCountryId;
    String? selectedCountryName = initialCountryName;
    String? selectedStateId = initialStateId;
    String? selectedStateName = initialStateName;
    String? selectedCityId = initialCityId;
    String? selectedCityName = initialCityName;
    bool isLoadingCountries = false;
    bool isLoadingStates = false;
    bool isLoadingCities = false;
    bool isSaving = false;
    bool hasInitialized = false;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF1C202C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            if (!hasInitialized) {
              hasInitialized = true;
              Future.microtask(() async {
                setSheetState(() => isLoadingCountries = true);
                try {
                  final loadedCountries = await authRepo.getCountries();
                  countries = loadedCountries;

                  if (selectedCountryId == null && countries.isNotEmpty) {
                    try {
                      final defaultCountry = countries.firstWhere(
                        (c) =>
                            c.name.trim().toLowerCase() == 'india' ||
                            c.isoCode?.trim().toUpperCase() == 'IN' ||
                            c.phoneCode?.trim().replaceAll('+', '') == '91',
                      );
                      selectedCountryId = defaultCountry.id;
                      selectedCountryName = defaultCountry.name;
                    } catch (_) {
                      selectedCountryId = countries.first.id;
                      selectedCountryName = countries.first.name;
                    }
                  } else if (selectedCountryId != null &&
                      (selectedCountryName == null || selectedCountryName!.isEmpty)) {
                    try {
                      selectedCountryName =
                          countries.firstWhere((c) => c.id == selectedCountryId).name;
                    } catch (_) {}
                  }

                  setSheetState(() => isLoadingCountries = false);

                  if (selectedCountryId != null) {
                    setSheetState(() => isLoadingStates = true);
                    final loadedStates = await authRepo.getStates(selectedCountryId!);
                    states = loadedStates;

                    if (selectedStateId == null && (initialStateName?.isNotEmpty ?? false)) {
                      try {
                        final matchedState = states.firstWhere(
                          (s) => s.name.trim().toLowerCase() == initialStateName!.trim().toLowerCase(),
                        );
                        selectedStateId = matchedState.id;
                        selectedStateName = matchedState.name;
                      } catch (_) {}
                    } else if (selectedStateId != null && (selectedStateName == null || selectedStateName!.isEmpty)) {
                      try {
                        selectedStateName = states.firstWhere((s) => s.id == selectedStateId).name;
                      } catch (_) {}
                    }

                    if (selectedStateId != null && !states.any((s) => s.id == selectedStateId)) {
                      selectedStateId = null;
                      selectedStateName = null;
                      selectedCityId = null;
                      selectedCityName = null;
                    }
                    setSheetState(() => isLoadingStates = false);

                    if (selectedStateId != null) {
                      setSheetState(() => isLoadingCities = true);
                      final loadedCities = await authRepo.getCities(
                        countryId: selectedCountryId!,
                        stateId: selectedStateId!,
                      );
                      cities = loadedCities;

                      if (selectedCityId == null && (initialCityName?.isNotEmpty ?? false)) {
                        try {
                          final matchedCity = cities.firstWhere(
                            (c) => c.name.trim().toLowerCase() == initialCityName!.trim().toLowerCase(),
                          );
                          selectedCityId = matchedCity.id;
                          selectedCityName = matchedCity.name;
                        } catch (_) {}
                      } else if (selectedCityId != null && (selectedCityName == null || selectedCityName!.isEmpty)) {
                        try {
                          selectedCityName = cities.firstWhere((c) => c.id == selectedCityId).name;
                        } catch (_) {}
                      }

                      if (selectedCityId != null && !cities.any((c) => c.id == selectedCityId)) {
                        selectedCityId = null;
                        selectedCityName = null;
                      }
                      setSheetState(() => isLoadingCities = false);
                    }
                  }
                } catch (_) {
                  setSheetState(() {
                    isLoadingCountries = false;
                    isLoadingStates = false;
                    isLoadingCities = false;
                  });
                }
              });
            }

            final localizations = sheetContext.localizations;

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Address',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () => Navigator.of(sheetContext).pop(),
                          ),
                        ],
                      ),
                      const Gap(16),

                      // Country Picker Field
                      _buildPickerField(
                        label: 'Country',
                        valueText: selectedCountryName,
                        hintText: isLoadingCountries
                            ? localizations.loadingCountries
                            : localizations.registerCountryHint,
                        isLoading: isLoadingCountries,
                        onTap: () async {
                          FocusScope.of(sheetContext).unfocus();
                          if (isLoadingCountries) return;
                          if (countries.isEmpty) {
                            setSheetState(() => isLoadingCountries = true);
                            try {
                              countries = await authRepo.getCountries();
                            } catch (_) {}
                            setSheetState(() => isLoadingCountries = false);
                          }
                          if (countries.isEmpty) return;

                          final selected =
                              await LocationPickerBottomSheet.show<LocationCountry>(
                            context: sheetContext,
                            title: localizations.registerCountryHint,
                            searchHint: localizations.searchCountry,
                            items: countries,
                            itemLabel: (country) => country.name,
                            itemId: (country) => country.id,
                            selectedId: selectedCountryId,
                            isDark: true,
                          );

                          if (selected != null) {
                            setSheetState(() {
                              selectedCountryId = selected.id;
                              selectedCountryName = selected.name;
                              selectedStateId = null;
                              selectedStateName = null;
                              selectedCityId = null;
                              selectedCityName = null;
                              states = [];
                              cities = [];
                              isLoadingStates = true;
                            });
                            try {
                              final loadedStates =
                                  await authRepo.getStates(selected.id);
                              setSheetState(() {
                                states = loadedStates;
                                isLoadingStates = false;
                              });
                            } catch (_) {
                              setSheetState(() => isLoadingStates = false);
                            }
                          }
                        },
                      ),
                      const Gap(16),

                      // State Picker Field
                      _buildPickerField(
                        label: 'State',
                        valueText: selectedStateName,
                        hintText: selectedCountryId == null
                            ? localizations.selectCountryFirst
                            : (isLoadingStates
                                ? localizations.loadingStates
                                : localizations.registerStateHint),
                        isLoading: isLoadingStates,
                        onTap: () async {
                          FocusScope.of(sheetContext).unfocus();
                          if (selectedCountryId == null) {
                            showGeneralMessage(
                              context: this.context,
                              content: localizations.pleaseSelectCountryFirst,
                            );
                            return;
                          }
                          if (isLoadingStates) return;
                          if (states.isEmpty) {
                            setSheetState(() => isLoadingStates = true);
                            try {
                              states =
                                  await authRepo.getStates(selectedCountryId!);
                            } catch (_) {}
                            setSheetState(() => isLoadingStates = false);
                          }

                          final selected =
                              await LocationPickerBottomSheet.show<LocationState>(
                            context: sheetContext,
                            title: localizations.registerStateHint,
                            searchHint: localizations.searchState,
                            items: states,
                            itemLabel: (s) => s.name,
                            itemId: (s) => s.id,
                            selectedId: selectedStateId,
                            isDark: true,
                          );

                          if (selected != null) {
                            setSheetState(() {
                              selectedStateId = selected.id;
                              selectedStateName = selected.name;
                              selectedCityId = null;
                              selectedCityName = null;
                              cities = [];
                              isLoadingCities = true;
                            });
                            try {
                              final loadedCities = await authRepo.getCities(
                                countryId: selectedCountryId!,
                                stateId: selected.id,
                              );
                              setSheetState(() {
                                cities = loadedCities;
                                isLoadingCities = false;
                              });
                            } catch (_) {
                              setSheetState(() => isLoadingCities = false);
                            }
                          }
                        },
                      ),
                      const Gap(16),

                      // City Picker Field
                      _buildPickerField(
                        label: 'City',
                        valueText: selectedCityName,
                        hintText: selectedStateId == null
                            ? localizations.selectStateFirst
                            : (isLoadingCities
                                ? localizations.loadingCities
                                : (cities.isEmpty
                                    ? localizations.noCitiesAvailable
                                    : localizations.registerCityHint)),
                        isLoading: isLoadingCities,
                        onTap: () async {
                          FocusScope.of(sheetContext).unfocus();
                          if (selectedStateId == null) {
                            showGeneralMessage(
                              context: this.context,
                              content: localizations.pleaseSelectStateFirst,
                            );
                            return;
                          }
                          if (isLoadingCities) return;
                          if (cities.isEmpty) {
                            showGeneralMessage(
                              context: this.context,
                              content: localizations.noCitiesAvailable,
                            );
                            return;
                          }

                          final selected =
                              await LocationPickerBottomSheet.show<LocationCity>(
                            context: sheetContext,
                            title: localizations.registerCityHint,
                            searchHint: localizations.searchCity,
                            items: cities,
                            itemLabel: (c) => c.name,
                            itemId: (c) => c.id,
                            selectedId: selectedCityId,
                            isDark: true,
                          );

                          if (selected != null) {
                            setSheetState(() {
                              selectedCityId = selected.id;
                              selectedCityName = selected.name;
                            });
                          }
                        },
                      ),
                      const Gap(16),

                      // Full Address Field
                      TextField(
                        controller: addressController,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Full Address',
                          labelStyle: const TextStyle(color: Color(0xFF8E95A5)),
                          hintText: 'Enter full address',
                          hintStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF12151D),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF2E3548)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF547AFF)),
                          ),
                        ),
                      ),
                      const Gap(16),

                      // Pincode Field
                      TextField(
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                          labelStyle: const TextStyle(color: Color(0xFF8E95A5)),
                          hintText: 'Enter pincode',
                          hintStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF12151D),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF2E3548)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF547AFF)),
                          ),
                        ),
                      ),
                      const Gap(24),

                      // Save Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4E73F8),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: isSaving
                            ? null
                            : () {
                                final addr = addressController.text.trim();
                                final pin = pincodeController.text.trim();
                                if (addr.isEmpty) {
                                  showGeneralMessage(
                                      context: this.context,
                                      content: 'Please enter address');
                                  return;
                                }
                                setSheetState(() => isSaving = true);
                                this.context.read<UserProfileBloc>().add(
                                      UpdateUserProfile(
                                        address: addr,
                                        pincode: pin.isNotEmpty ? pin : null,
                                        countryId: selectedCountryId,
                                        countryName: selectedCountryName,
                                        stateId: selectedStateId,
                                        stateName: selectedStateName,
                                        cityId: selectedCityId,
                                        cityName: selectedCityName,
                                      ),
                                    );
                                setState(() => _cachedAddress = addr);
                                final userRepo =
                                    RepositoryProvider.of<UserRepository>(
                                        this.context);
                                userRepo.saveAddress(addr);
                                Navigator.of(sheetContext).pop();
                                showSuccessMessage(
                                  context: this.context,
                                  content: 'Address updated successfully!',
                                );
                              },
                        child: isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPickerField({
    required String label,
    required String? valueText,
    required String hintText,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    final hasValue = valueText != null && valueText.trim().isNotEmpty;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF8E95A5)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: const Color(0xFF12151D),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2E3548)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF547AFF)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1E2330)),
          ),
          suffixIcon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF547AFF),
                      ),
                    ),
                  ),
                )
              : const Icon(Icons.arrow_drop_down, color: Color(0xFF547AFF)),
        ),
        child: Text(
          hasValue ? valueText : hintText,
          style: TextStyle(
            color: hasValue ? Colors.white : Colors.white70,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.select<UserProfileBloc, UserData?>(
      (bloc) => bloc.state.data,
    );

    final phone = (userData?.phoneNumber?.isNotEmpty ?? false)
        ? userData!.phoneNumber!
        : '8141362869';

    final email = (userData?.email.isNotEmpty ?? false)
        ? userData!.email
        : 'gauravshingala007@gmail.com';

    final rawAddress = (userData?.address?.isNotEmpty ?? false)
        ? userData!.address!
        : (_cachedAddress?.isNotEmpty ?? false ? _cachedAddress! : '');

    final displayAddress = () {
      final parts = <String>[];
      if (rawAddress.isNotEmpty) {
        parts.add(rawAddress);
      }
      if (userData?.cityName?.isNotEmpty ?? false) {
        if (!parts.any((p) => p.toLowerCase().contains(userData!.cityName!.toLowerCase()))) {
          parts.add(userData!.cityName!);
        }
      }
      if (userData?.stateName?.isNotEmpty ?? false) {
        if (!parts.any((p) => p.toLowerCase().contains(userData!.stateName!.toLowerCase()))) {
          parts.add(userData!.stateName!);
        }
      }
      if (userData?.countryName?.isNotEmpty ?? false) {
        if (!parts.any((p) => p.toLowerCase().contains(userData!.countryName!.toLowerCase()))) {
          parts.add(userData!.countryName!);
        }
      }
      if (userData?.pincode?.isNotEmpty ?? false) {
        if (!parts.any((p) => p.contains(userData!.pincode!))) {
          parts.add(userData!.pincode!);
        }
      }
      return parts.isNotEmpty
          ? parts.join(', ')
          : '372 punagam hastinapur society choryasi surat gujarat india 395010';
    }();

    final String firstName;
    final String lastName;
    if (userData?.firstName != null && userData!.firstName!.isNotEmpty) {
      firstName = userData.firstName!;
      lastName = userData.lastName ?? '';
    } else if (userData?.fullName != null && userData!.fullName.isNotEmpty) {
      final parts = userData.fullName.trim().split(RegExp(r'\s+'));
      firstName = parts.isNotEmpty ? parts.first : '';
      lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    } else {
      firstName = 'John';
      lastName = 'Doe';
    }

    final displayName = '$firstName $lastName'.trim();

    return Scaffold(
      backgroundColor: const Color(0xFF12151D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12151D),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Personal Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            _buildContactItem(
              icon: Icons.phone_outlined,
              label: 'Phone Number',
              value: phone,
              onEdit: () {
                _showEditFieldSheet(
                  title: 'Phone Number',
                  initialValue: phone,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  onSave: (value) {
                    context.read<UserProfileBloc>().add(
                          UpdateUserProfile(phoneNumber: value),
                        );
                  },
                );
              },
            ),
            const Gap(24),
            _buildContactItem(
              icon: Icons.mail_outline,
              label: 'Email',
              value: email,
              onEdit: () {
                _showEditFieldSheet(
                  title: 'Email',
                  initialValue: email,
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  onSave: (value) {
                    context.read<UserProfileBloc>().add(
                          UpdateUserProfile(email: value),
                        );
                  },
                );
              },
            ),
            const Gap(24),
            _buildContactItem(
              icon: Icons.location_on_outlined,
              label: 'Address',
              value: displayAddress,
              onEdit: () {
                _showEditAddressSheet(
                  initialAddress: rawAddress,
                  initialPincode: userData?.pincode ?? '',
                  initialCountryId: userData?.countryId,
                  initialCountryName: userData?.countryName,
                  initialStateId: userData?.stateId,
                  initialStateName: userData?.stateName,
                  initialCityId: userData?.cityId,
                  initialCityName: userData?.cityName,
                );
              },
            ),
            const Gap(32),
            const Divider(color: Color(0xFF1F2432), height: 1),
            const Gap(24),
            InkWell(
              onTap: () {
                _showEditNameSheet(
                  currentFirstName: firstName,
                  currentLastName: lastName,
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(4),
                          const Text(
                            'Update First Name and Last Name',
                            style: TextStyle(
                              color: Color(0xFF8E95A5),
                              fontSize: 13,
                            ),
                          ),
                          const Gap(6),
                          Text(
                            displayName.isNotEmpty ? displayName : 'Update Name',
                            style: const TextStyle(
                              color: Color(0xFF547AFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF6B7280),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF7582A0), size: 22),
        const Gap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF8E95A5),
                  fontSize: 14,
                ),
              ),
              const Gap(4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: Color(0xFF547AFF),
            size: 20,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onEdit,
        ),
      ],
    );
  }
}
