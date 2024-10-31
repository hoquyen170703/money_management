import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../calendar_view_model.dart';
import '../models/week_day.dart';
import 'calendar_grid_view_item.dart';

class CalendarGridView extends ConsumerWidget {
  const CalendarGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarDataList =
        ref.watch(calendarViewModelProvider).value?.calendarDataList ?? [];
    const height = 40.0;
    final itemCount = WeekDay.values.length;
    final childAspectRatio = (MediaQuery.of(context).size.width - 0.5 * (itemCount - 1)) / itemCount / height;

    return Container(
      color: ref.colors.disable,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: WeekDay.values.length,
          mainAxisSpacing: 0.5,
          crossAxisSpacing: 0.5,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          final calendarData = calendarDataList[index];
          return CalendarGridViewItem(calendarData: calendarData);
        },
        itemCount: calendarDataList.length,
      ),
    );
  }
}
