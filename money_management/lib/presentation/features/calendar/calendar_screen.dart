import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/extensions/widget_ref_extension.dart';
import '../../common_widgets/base/base_screen.dart';
import 'calendar_state.dart';
import 'calendar_view_model.dart';
import 'widgets/calendar_date_row_item.dart';
import 'widgets/calendar_record_list_view.dart';
import 'widgets/calendar_statistic_row_item.dart';
import 'widgets/calendar_view.dart';

class CalendarScreen extends BaseScreen {
  const CalendarScreen({super.key});

  @override
  BaseScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState
    extends BaseScreenState<CalendarScreen, CalendarViewModel, CalendarState> {
  @override
  Color? get backgroundColor => ref.colors.background;

  @override
  void onInitState() {
    super.onInitState();
    viewModel.init();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        ref.appLocalizations.calendar,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return const Column(
      children: [
        CalendarDateRowItem(),
        CalendarView(),
        CalendarStatisticRowItem(),
        Expanded(child: CalendarRecordListView()),
      ],
    );
  }

  @override
  AsyncValue<CalendarState> get state => ref.watch(calendarViewModelProvider);

  @override
  CalendarViewModel get viewModel =>
      ref.read(calendarViewModelProvider.notifier);
}
