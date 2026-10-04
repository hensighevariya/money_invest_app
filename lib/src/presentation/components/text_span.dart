import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkTextSpan extends TextSpan {
  const LinkTextSpan({required super.text, super.style, required this.onPressed});

  final VoidCallback? onPressed;
}

class LinkText extends StatelessWidget {
  const LinkText({super.key, required this.spans, this.style, this.textAlign});

  final List<TextSpan> spans;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveTextStyle = DefaultTextStyle.of(
      context,
    ).style.copyWith(color: theme.colorScheme.onSurfaceVariant).merge(style);

    final linkTextStyle = effectiveTextStyle.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600);

    return Text.rich(
      TextSpan(
        children:
            spans.map((span) {
              if (span is LinkTextSpan && span.onPressed != null) {
                return TextSpan(
                  text: span.text,
                  style: linkTextStyle.merge(span.style),
                  recognizer: TapGestureRecognizer()..onTap = span.onPressed,
                );
              } else {
                return span;
              }
            }).toList(),
      ),
      style: effectiveTextStyle.merge(style),
      textAlign: textAlign,
    );
  }
}
