import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/category_type.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../input_view_model.dart';

class InputTypeRowItem extends ConsumerWidget {
  const InputTypeRowItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryType =
        ref.watch(inputViewModelProvider).value?.categoryType ??
            CategoryType.expense;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: ref.colors.cellBackground,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Text(
              ref.appLocalizations.type,
              style: TextStyle(
                color: ref.colors.mainText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSlidingSegmentedControl<CategoryType>(
                  initialValue: categoryType,
                  children: {
                    CategoryType.expense: Text(
                      CategoryType.expense.getTitle(ref),
                      style: TextStyle(color: ref.colors.mainText),
                    ),
                    CategoryType.income: Text(
                      CategoryType.income.getTitle(ref),
                      style: TextStyle(color: ref.colors.mainText),
                    ),
                  },
                  decoration: BoxDecoration(
                    color: ref.colors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: ref.colors.cellBackground,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  onValueChanged: (categoryType) {
                    ref
                        .read(inputViewModelProvider.notifier)
                        .onCategoryTypeChanged(categoryType);
                  },
                  fromMax: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 48,
          ),
        ],
      ),
    );
  }
}
