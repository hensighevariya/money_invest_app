import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int selectedIndex;
  final int itemCount;
  final Color? color;
  final Color? unselectedColor;
  final double selectedHeight;
  final double height;
  final double selectedWidth;
  final double width;
  final double gap;

  const DotsIndicator({
    super.key,
    required this.itemCount,
    required this.selectedIndex,
    this.color,
    this.unselectedColor,
    this.gap = 8,
    double? selectedHeight,
    double? height,
    double? selectedWidth,
    double? width,
  }) : assert(itemCount > 0),
       assert(selectedIndex >= 0 && selectedIndex < itemCount),
       assert(gap >= 0),
       assert(selectedWidth == null || selectedWidth > 0),
       assert(width == null || width > 0),
       assert(selectedHeight == null || selectedHeight > 0),
       assert(height == null || height > 0),
       selectedHeight = selectedHeight ?? height ?? 8,
       height = height ?? 8,
       selectedWidth = selectedWidth ?? width ?? 16,
       width = width ?? 8;

  const DotsIndicator.circle({
    super.key,
    required this.itemCount,
    required this.selectedIndex,
    double selectedRadius = 6,
    double radius = 4,
    this.color,
    this.unselectedColor,
    this.gap = 4,
  }) : assert(itemCount > 0),
       assert(selectedIndex >= 0 && selectedIndex < itemCount),
       assert(gap >= 0),
       assert(radius > 0),
       assert(selectedRadius > 0),
       selectedHeight = selectedRadius * 2,
       height = radius * 2,
       selectedWidth = selectedRadius * 2,
       width = radius * 2;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var selectedColor = color ?? colorScheme.primary;
    var unselectedColor = this.unselectedColor ?? colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        bool isSelected = selectedIndex == index;
        return AnimatedContainer(
          curve: Curves.ease,
          width: isSelected ? selectedWidth : width,
          height: isSelected ? selectedHeight : height,
          duration: const Duration(milliseconds: 500),
          margin: EdgeInsets.symmetric(horizontal: gap / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? selectedColor : unselectedColor,
          ),
        );
      }),
    );
  }
}
