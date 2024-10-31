import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../models/calendar_data.dart';

class CalendarGridViewItem extends ConsumerWidget {
  const CalendarGridViewItem({
    required this.calendarData,
    super.key,
  });

  final CalendarData calendarData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: calendarData.isCurrentMonth
          ? ref.colors.cellBackground
          : ref.colors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              calendarData.date.day.toString(),
              style: TextStyle(
                color: _getTitleColor(calendarData.date, ref),
                fontSize: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  calendarData.totalIncome?.toThousandFormatAmount() ?? '',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  calendarData.totalExpense?.toThousandFormatAmount() ?? '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTitleColor(DateTime date, WidgetRef ref) {
    final weekday = date.weekday;
    if (weekday == DateTime.sunday) {
      return Colors.red;
    } else if (weekday == DateTime.saturday) {
      return Colors.blue;
    } else {
      return ref.colors.mainText;
    }
  }
}
