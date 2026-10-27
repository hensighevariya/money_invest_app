import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class LocationPickerBottomSheet<T> extends StatefulWidget {
  const LocationPickerBottomSheet({
    super.key,
    required this.title,
    required this.searchHint,
    required this.items,
    required this.itemLabel,
    required this.onSelected,
    this.selectedId,
    this.itemId,
    this.noResultsText,
  });

  final String title;
  final String searchHint;
  final List<T> items;
  final String Function(T item) itemLabel;
  final String Function(T item)? itemId;
  final String? selectedId;
  final String? noResultsText;
  final ValueChanged<T> onSelected;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String searchHint,
    required List<T> items,
    required String Function(T item) itemLabel,
    String Function(T item)? itemId,
    String? selectedId,
    String? noResultsText,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LocationPickerBottomSheet<T>(
        title: title,
        searchHint: searchHint,
        items: items,
        itemLabel: itemLabel,
        itemId: itemId,
        selectedId: selectedId,
        noResultsText: noResultsText,
        onSelected: (item) => Navigator.of(context).pop(item),
      ),
    );
  }

  @override
  State<LocationPickerBottomSheet<T>> createState() =>
      _LocationPickerBottomSheetState<T>();
}

class _LocationPickerBottomSheetState<T>
    extends State<LocationPickerBottomSheet<T>> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.items.where((item) {
      if (_query.trim().isEmpty) return true;
      final label = widget.itemLabel(item).toLowerCase();
      return label.contains(_query.trim().toLowerCase());
    }).toList();

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.75,
          child: Column(
            children: [
              const Gap(12),
              // Drag handle matching screenshot
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(12),
              // Title matching screenshot
              Text(
                widget.title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(14),
              Divider(
                height: 1,
                color: context.colorScheme.outlineVariant.withValues(alpha: 0.2),
              ),
              const Gap(16),
              // Search field matching screenshot
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
                child: CommonTextField(
                  controller: _searchController,
                  hintText: widget.searchHint,
                  fillColor: context.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.outlineVariant.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.outlineVariant.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.primary.withValues(alpha: 0.8),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 22,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                  onChanged: (val) {
                    setState(() => _query = val);
                  },
                ),
              ),
              const Gap(12),
              // Items List
              Expanded(
                child: filteredItems.isEmpty
                    ? Center(
                        child: Text(
                          widget.noResultsText ??
                              context.localizations.noResultsFound,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.large,
                          vertical: Spacing.small,
                        ),
                        itemCount: filteredItems.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.15,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          final label = widget.itemLabel(item);
                          final id = widget.itemId?.call(item);
                          final isSelected =
                              widget.selectedId != null &&
                              widget.selectedId == id;

                          return InkWell(
                            onTap: () => widget.onSelected(item),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 4,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      label,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: isSelected
                                                ? context.colorScheme.primary
                                                : context.colorScheme.onSurface,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check,
                                      size: 20,
                                      color: context.colorScheme.primary,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
