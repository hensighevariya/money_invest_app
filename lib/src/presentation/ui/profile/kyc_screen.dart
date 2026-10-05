import 'dart:io';

import 'package:common_extensions/common_extensions.dart';
import 'package:dotted_border/dotted_border.dart';
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
  String _selectedIdentityType = 'ID Card';
  File? _firstDocument;
  File? _secondDocument;

  Future<void> _pickDocument(bool isFirst) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          if (isFirst) {
            _firstDocument = File(image.path);
          } else {
            _secondDocument = File(image.path);
          }
        });
      }
    } catch (e) {
      debugPrint("Error picking document: $e");
    }
  }

  Widget _buildIdentityTypeRadio(String type, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: type,
          groupValue: _selectedIdentityType,
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                _selectedIdentityType = value;
              });
            }
          },
          activeColor: context.colorScheme.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        const Gap(Spacing.xSmall),
        Text(type, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        const Gap(Spacing.small),
      ],
    );
  }

  Widget _buildDocumentUploadBox(BuildContext context, bool isFirst) {
    final File? currentDocument = isFirst ? _firstDocument : _secondDocument;
    final String label = context.localizations.kycUploadIdCard(_selectedIdentityType);
    final String subLabel = isFirst ? context.localizations.kycFirstDocument : context.localizations.kycSecondDocument;

    return GestureDetector(
      onTap: () => _pickDocument(isFirst),
      child: DottedBorder(
        color: Colors.grey.shade400,
        strokeWidth: 1.5,
        dashPattern: const [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: currentDocument != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(currentDocument, fit: BoxFit.cover),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const Icon(Icons.image, size: 50, color: Colors.grey),
                        Positioned(
                          bottom: 0,
                          right: -4,
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_upward, size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const Gap(Spacing.small),
                    Text(label, style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
                    const Gap(Spacing.xSmall),
                    Text(subLabel, style: context.textTheme.labelMedium?.copyWith(color: Colors.grey)),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.kycTitle,
        color: context.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localizations.kycProofOfIdentity,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(Spacing.small),
              Text(
                context.localizations.kycDescription1,
                style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400, height: 1.4),
              ),
              const Gap(Spacing.small),
              Text(
                context.localizations.kycDescription2,
                style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400, height: 1.4),
              ),
              const Gap(Spacing.small),
              Text(
                context.localizations.kycDescription3,
                style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400, height: 1.4),
              ),
              const Gap(Spacing.xLarge),
              Text(
                context.localizations.kycChooseIdentityType,
                style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(Spacing.small),
              Wrap(
                children: [
                  _buildIdentityTypeRadio(context.localizations.kycIdCard, context),
                  _buildIdentityTypeRadio(context.localizations.kycPassport, context),
                  _buildIdentityTypeRadio(context.localizations.kycDrivingLicense, context),
                ],
              ),
              const Gap(Spacing.xLarge),
              _buildDocumentUploadBox(context, true),
              const Gap(Spacing.large),
              _buildDocumentUploadBox(context, false),
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
                // TODO: Implement Save action
              },
              child: Text(context.localizations.kycSaveButton),
            ),
          ),
        ),
      ),
    );
  }
}
