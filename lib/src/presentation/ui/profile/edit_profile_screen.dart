import 'package:common_extensions/common_extensions.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/components/image.dart';
import 'package:money_invest_app/src/presentation/components/mobile_number_field.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:ui_components/ui_components.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'hensi');
  final TextEditingController _surnameController = TextEditingController(text: 'patel');
  final TextEditingController _dobController = TextEditingController(text: '2000-05-07');
  final TextEditingController _emailController = TextEditingController(text: 'hensi.g@elaunchinfotech.in');
  final MobileNumberController _mobileNumberController = MobileNumberController();

  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(showLeading: true, title: "Edit Profile", color: context.colorScheme.surface),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        border: Border.all(color: context.colorScheme.primary),
                        shape: BoxShape.circle,
                      ),
                      child: _profileImage != null
                          ? Image.file(_profileImage!, fit: BoxFit.cover, width: 120, height: 120)
                          : const Center(child: SvgIcon(VectorImages.userPlaceholder, size: 80)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: context.colorScheme.surface, width: 2),
                          ),
                          child: Icon(Icons.camera_alt, color: context.colorScheme.onPrimary, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Spacing.xLarge),
              InputFieldDecoration(
                labelText: "Name",
                child: CommonTextField(controller: _nameController, prefixIcon: const Icon(Icons.person_outline)),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "Surname",
                child: CommonTextField(controller: _surnameController, prefixIcon: const Icon(Icons.person_outline)),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "Date of Birth",
                child: CommonTextField(
                  controller: _dobController,
                  readOnly: true,
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _dobController.text =
                            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "Email Address",
                child: CommonTextField(
                  controller: _emailController,
                  prefixIcon: const Icon(Icons.email_outlined),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        minimumSize: const Size(60, 30),
                      ),
                      child: const Text("Change"),
                    ),
                  ),
                ),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "Mobile Number",
                child: MobileNumberField(
                  controller: _mobileNumberController,
                  hintText: "Your mobile number",
                  keyboardType: TextInputType.phone,
                  inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  isMobileField: true,
                ),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "Country",
                child: DropdownButtonFormField<String>(
                  icon: SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                  decoration: const InputDecoration(hintText: "Select Country"),
                  initialValue: _selectedCountry,
                  items: ['United States', 'India', 'United Kingdom'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedCountry = value),
                ),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "State",
                child: DropdownButtonFormField<String>(
                  icon: SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                  decoration: const InputDecoration(hintText: "Select State"),
                  initialValue: _selectedState,
                  items: ['State 1', 'State 2', 'State 3'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedState = value),
                ),
              ),
              const Gap(Spacing.normal),
              InputFieldDecoration(
                labelText: "City",
                child: DropdownButtonFormField<String>(
                  icon: SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                  decoration: const InputDecoration(hintText: "Select City"),
                  initialValue: _selectedCity,
                  items: ['City 1', 'City 2', 'City 3'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedCity = value),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(Spacing.large),
        child: ElevatedButton(
          style: ElevatedButtonPrimaryStyle(context, buttonColor: context.colorScheme.primary),
          onPressed: () {},
          child: const Text("Save"),
        ),
      ),
    );
  }
}
