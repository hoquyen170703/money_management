import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../data/models/db/db_record_view.dart';
import '../../../../utilities/extensions/date_time_extension.dart';
import '../../../../utilities/extensions/int_extension.dart';
import '../calendar_view_model.dart';
import 'calendar_record_list_view_header.dart';
import 'calendar_record_list_view_item.dart';

class CalendarRecordListView extends ConsumerWidget {
  const CalendarRecordListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbRecordViewList =
        ref.watch(calendarViewModelProvider).value?.dbRecordViewList ?? [];

    return GroupedListView<DbRecordView, DateTime>(
      elements: dbRecordViewList,
      groupBy: (dbRecordView) =>
          dbRecordView.date.toDateTime().startOfCurrentDate,
      groupSeparatorBuilder: (date) => CalendarRecordListViewHeader(date: date),
      itemBuilder: (context, dbRecordView) =>
          CalendarRecordListViewItem(dbRecordView: dbRecordView),
      itemComparator: (dbRecordView1, dbRecordView2) =>
          dbRecordView1.createdAt.compareTo(dbRecordView2.createdAt),
      useStickyGroupSeparators: true,
      floatingHeader: true,
      order: GroupedListOrder.DESC,
    );
  }
}
