import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../models/week_day.dart';

class CalendarWeekDayItem extends ConsumerWidget {
  const CalendarWeekDayItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const height = 24.0;
    final itemCount = WeekDay.values.length;
    final childAspectRatio = (MediaQuery.of(context).size.width - 0.5 * (itemCount - 1)) / itemCount / height;

    return Container(
      height: height,
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
          return _buildWeekDayTitle(WeekDay.values[index], ref);
        },
        itemCount: itemCount,
      ),
    );
  }

  Widget _buildWeekDayTitle(WeekDay weekDay, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      color: ref.colors.tint,
      child: Text(
        weekDay.getTitle(ref),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: weekDay.getTitleColor(),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
