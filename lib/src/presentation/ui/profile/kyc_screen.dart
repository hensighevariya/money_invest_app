import 'dart:io';

import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  String _selectedDocumentType = 'Aadhaar Card';
  File? _frontImage;
  File? _backImage;
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _accountHolderController =
      TextEditingController();

  Future<void> _pickDocument(bool isFront) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          if (isFront) {
            _frontImage = File(image.path);
          } else {
            _backImage = File(image.path);
          }
        });
      }
    } catch (e) {
      debugPrint("Error picking document: $e");
    }
  }

  Widget _buildImageUploader(BuildContext context, String label, bool isFront) {
    final File? currentImage = isFront ? _frontImage : _backImage;

    return GestureDetector(
      onTap: () => _pickDocument(isFront),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.colorScheme.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
          ),
        ),
        padding: const EdgeInsets.all(Spacing.small),
        child: currentImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(currentImage, fit: BoxFit.cover),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(Spacing.medium),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: context.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _docNumberController.dispose();
    _accountHolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: '',
        color: context.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localizations.kycVerification,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(Spacing.small),
              Text(
                context.localizations.kycSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const Gap(Spacing.xLarge),

              Text(
                context.localizations.kycDocumentType,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(Spacing.small),
              DropdownButtonFormField<String>(
                initialValue: _selectedDocumentType,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Spacing.medium,
                    vertical: Spacing.small,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                items:
                    [
                          context.localizations.kycAadhaarCard,
                          context.localizations.kycPanCard,
                          context.localizations.kycVoterId,
                        ]
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedDocumentType = value;
                    });
                  }
                },
              ),
              const Gap(Spacing.large),

              Text(
                context.localizations.kycDocumentNumber,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(Spacing.small),
              TextFormField(
                controller: _docNumberController,
                decoration: InputDecoration(
                  hintText: context.localizations.kycHintDocNumber,
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Spacing.medium,
                    vertical: Spacing.medium,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const Gap(Spacing.large),

              Row(
                children: [
                  Expanded(
                    child: _buildImageUploader(
                      context,
                      context.localizations.kycFrontImage,
                      true,
                    ),
                  ),
                  const Gap(Spacing.medium),
                  Expanded(
                    child: _buildImageUploader(
                      context,
                      context.localizations.kycBackImage,
                      false,
                    ),
                  ),
                ],
              ),
              const Gap(Spacing.xLarge),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.large),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement verification submit
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                context.localizations.kycSubmitForVerification,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
