import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../utilities/extensions/date_time_extension.dart';
import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../calendar_view_model.dart';

class CalendarRecordListViewHeader extends ConsumerWidget {
  const CalendarRecordListViewHeader({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarDataList =
        ref.watch(calendarViewModelProvider).value?.calendarDataList ?? [];
    final calendarData = calendarDataList
        .where((element) => element.date.isAtSameMomentAs(date))
        .toList()
        .firstOrNull;
    final totalIncome = calendarData?.totalIncome ?? 0;
    final totalExpense = calendarData?.totalExpense ?? 0;
    final total = totalIncome - totalExpense;

    return Container(
      height: 24,
      color: ref.colors.tint,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Text(
            date.toDateString(format: Constants.dayFormat, ref: ref),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            total.toThousandFormatAmount(withUnit: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
