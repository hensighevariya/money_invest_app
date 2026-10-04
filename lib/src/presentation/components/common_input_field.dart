import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:ui_components/ui_components.dart';

class InputFieldLabel extends StatelessWidget {
  const InputFieldLabel(this.data, {super.key, this.isRequired = false});

  final String data;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isRequired) {
      return Text.rich(
        TextSpan(
          text: data,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
          children: [
            TextSpan(
              text: ' *',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
            ),
          ],
        ),
      );
    }
    return Text(data, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer));
  }
}

class InputFieldDecoration extends StatelessWidget {
  const InputFieldDecoration({super.key, required this.labelText, this.isRequired = false, required this.child});

  final String labelText;
  final Widget child;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.xSmall,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputFieldLabel(labelText, isRequired: isRequired),
        child,
      ],
    );
  }
}

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? label;
  final Color? labelColor;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? suffix;
  final BoxConstraints? constraints;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final String obscuringCharacter;
  final String? suffixText;
  final String? counterText;
  final String? labelText;
  final String? errorText;
  final String? inputFieldLabel;
  final int? maxLines;
  final int? maxLength;
  final int? minLength;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String value)? onFieldSubmitted;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextCapitalization? textCapitalization;

  const CommonTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.labelText,
    this.autofocus = false,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.hintText,
    this.label,
    this.labelColor,
    this.validator,
    this.autoValidateMode,
    this.autofillHints,
    this.onChanged,
    this.prefixIcon,
    this.hoverColor,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffix,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.obscuringCharacter = '•',
    this.counterText,
    this.constraints,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.minLength,
    this.suffixText,
    this.fillColor,
    this.cursorColor,
    this.onTapOutside,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.contentPadding,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.textCapitalization,
    this.suffixIconConstraints,
    this.errorText,
    this.inputFieldLabel,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: Spacing.xSmall,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.inputFieldLabel != null) ...[InputFieldLabel(widget.inputFieldLabel ?? '')],
        TextFormField(
          enabled: widget.enabled,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          cursorColor: widget.cursorColor,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          style: theme.textTheme.titleSmall,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          validator: widget.validator,
          autovalidateMode: widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
          autofillHints: widget.autofillHints,
          onTapOutside: (event) => widget.onTapOutside ?? context.hideKeyboard(),
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,

          decoration: InputDecoration(
            hoverColor: widget.hoverColor,
            counterText: widget.counterText,
            contentPadding: widget.contentPadding,
            border: widget.border,
            suffix: widget.suffix,
            fillColor: widget.fillColor,
            suffixText: widget.suffixText,
            labelText: widget.labelText,
            suffixStyle: theme.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onTertiary),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            disabledBorder: widget.disabledBorder,
            constraints: widget.constraints,
            errorText: widget.errorText,
            suffixIcon: widget.suffixIcon != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: widget.suffixIcon) : null,
            prefixIconConstraints: widget.prefixIconConstraints ?? const BoxConstraints(minWidth: 48, maxHeight: 40),
            suffixIconConstraints: widget.suffixIconConstraints ?? const BoxConstraints(minWidth: 48, maxHeight: 40),
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}

