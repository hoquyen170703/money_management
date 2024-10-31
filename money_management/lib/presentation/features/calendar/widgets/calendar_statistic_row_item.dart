import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/category_type.dart';
import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../calendar_view_model.dart';

class CalendarStatisticRowItem extends ConsumerWidget {
  const CalendarStatisticRowItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalExpense = _getTotalAmount(
      ref: ref,
      categoryType: CategoryType.expense,
    );
    final totalIncome = _getTotalAmount(
      ref: ref,
      categoryType: CategoryType.income,
    );
    final total = totalIncome - totalExpense;

    return Container(
      height: 56,
      color: ref.colors.cellBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatisticItem(
            ref: ref,
            title: ref.appLocalizations.expense,
            value: totalExpense.toThousandFormatAmount(withUnit: true),
            valueColor: Colors.red,
          ),
          _buildStatisticItem(
            ref: ref,
            title: ref.appLocalizations.income,
            value: totalIncome.toThousandFormatAmount(withUnit: true),
            valueColor: Colors.blue,
          ),
          _buildStatisticItem(
            ref: ref,
            title: ref.appLocalizations.total,
            value:
                '${total >= 0 ? '+' : ''}${total.toThousandFormatAmount(withUnit: true)}',
            valueColor: total >= 0 ? Colors.blue : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem({
    required WidgetRef ref,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: ref.colors.mainText,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  int _getTotalAmount({
    required WidgetRef ref,
    required CategoryType categoryType,
  }) {
    final calendarDataList =
        ref.watch(calendarViewModelProvider).value?.calendarDataList ?? [];
    if (calendarDataList.isEmpty) {
      return 0;
    }
    switch (categoryType) {
      case CategoryType.income:
        return calendarDataList
            .map((e) => e.totalIncome ?? 0)
            .toList()
            .reduce((value, element) => value + element);
      case CategoryType.expense:
        return calendarDataList
            .map((e) => e.totalExpense ?? 0)
            .toList()
            .reduce((value, element) => value + element);
    }
  }
}
