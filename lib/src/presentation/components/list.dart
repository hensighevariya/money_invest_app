import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  const UnorderedList({super.key, required this.elements});

  final List<TextSpan> elements;

  @override
  Widget build(BuildContext context) {
    final effectiveChildren = List.generate(elements.length, (index) {
      final element = elements.elementAt(index);

      return _ListElement(
        key: Key('ul_$index'),
        leading: Transform.scale(scale: 1.5, child: const Text('•', style: TextStyle(fontWeight: FontWeight.w900))),
        data: element,
      );
    });

    return Column(spacing: Spacing.small, children: effectiveChildren);
  }
}

class OrderedList extends StatelessWidget {
  const OrderedList({super.key, required this.elements});

  final List<TextSpan> elements;

  @override
  Widget build(BuildContext context) {
    final effectiveChildren = List.generate(elements.length, (index) {
      final element = elements.elementAt(index);

      return _ListElement(key: Key('ol_$index'), leading: Text('${index + 1}.'), data: element);
    });

    return Column(spacing: Spacing.xSmall, children: effectiveChildren);
  }
}

class _ListElement extends StatelessWidget {
  const _ListElement({super.key, required this.data, required this.leading});

  final TextSpan data;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      spacing: Spacing.medium,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        DefaultTextStyle.merge(
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
          textAlign: TextAlign.start,
          child: leading,
        ),
        Flexible(child: Text.rich(data, textAlign: TextAlign.start)),
      ],
    );
  }
}
