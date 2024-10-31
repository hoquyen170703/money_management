import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';
import 'calendar_grid_view.dart';
import 'calendar_week_day_item.dart';

class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horizontalDivider = Container(
      height: 0.5,
      color: ref.colors.disable,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          horizontalDivider,
          const CalendarWeekDayItem(),
          horizontalDivider,
          const CalendarGridView(),
          horizontalDivider,
        ],
      ),
    );
  }
}
