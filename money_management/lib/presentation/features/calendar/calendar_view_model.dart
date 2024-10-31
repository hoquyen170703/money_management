import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/category_type.dart';
import '../../../data/models/db/db_record_view.dart';
import '../../../data/providers/db_repository_provider.dart';
import '../../../utilities/extensions/date_time_extension.dart';
import '../../../utilities/extensions/int_extension.dart';
import 'calendar_state.dart';
import 'models/calendar_data.dart';

part 'calendar_view_model.g.dart';

@Riverpod(dependencies: [dbRepository])
class CalendarViewModel extends _$CalendarViewModel {
  @override
  FutureOr<CalendarState> build() {
    return CalendarState(date: DateTime.now());
  }

  Future<void> init() async {
    await onMonthChange(DateTime.now());
  }

  Future<void> onNextMonth() async {
    final date = state.value?.date ?? DateTime.now();
    await onMonthChange(date.nextMonth);
  }

  Future<void> onPreviousMonth() async {
    final date = state.value?.date ?? DateTime.now();
    await onMonthChange(date.previousMonth);
  }

  Future<void> onMonthChange(DateTime date) async {
    await update(
      (state) => state.copyWith(
        date: date,
      ),
    );
    await saveStartAndEndOfCurrentMonth();
    await getDbRecords();
    await getCalendarData();
  }

  Future<void> saveStartAndEndOfCurrentMonth() async {
    final date = state.value?.date ?? DateTime.now();
    final startDateOfCurrentMonth =
        date.startDateOfCurrentMonth.startOfCurrentDate;
    final endDateOfCurrentMonth = date.endDateOfCurrentMonth.endOfCurrentDate;
    await update(
      (state) => state.copyWith(
        startDateOfCurrentMonth: startDateOfCurrentMonth,
        endDateOfCurrentMonth: endDateOfCurrentMonth,
      ),
    );
  }

  Future<void> getDbRecords() async {
    final startDateOfCurrentMonth =
        state.value?.startDateOfCurrentMonth ?? DateTime.now();
    final endDateOfCurrentMonth =
        state.value?.endDateOfCurrentMonth ?? DateTime.now();
    final dbRecordViewList = await ref.read(dbRepositoryProvider).getDbRecords(
          startDate: startDateOfCurrentMonth,
          endDate: endDateOfCurrentMonth,
        );
    final dbRecordViewMap = <DateTime, List<DbRecordView>>{};
    for (final dbRecordView in dbRecordViewList) {
      (dbRecordViewMap[dbRecordView.date.toDateTime().startOfCurrentDate] ??=
              [])
          .add(dbRecordView);
    }
    await update(
      (state) => state.copyWith(
        dbRecordViewMap: dbRecordViewMap,
        dbRecordViewList: dbRecordViewList,
      ),
    );
  }

  Future<void> getCalendarData() async {
    final calendarDataList = <CalendarData>[];
    final startDateOfCurrentMonth =
        state.value?.startDateOfCurrentMonth ?? DateTime.now();
    final endDateOfCurrentMonth =
        state.value?.endDateOfCurrentMonth ?? DateTime.now();

    // Add dates of previous month
    final numberAddingDatesOfPreviousMonth =
        startDateOfCurrentMonth.weekday - DateTime.monday;
    for (var i = numberAddingDatesOfPreviousMonth; i > 0; i--) {
      final date = startDateOfCurrentMonth.subtract(Duration(days: i));
      calendarDataList.add(
        CalendarData(
          date: date,
          isCurrentMonth: false,
          totalExpense: getTotalAmount(
            date: date,
            categoryType: CategoryType.expense,
          ),
          totalIncome: getTotalAmount(
            date: date,
            categoryType: CategoryType.income,
          ),
        ),
      );
    }

    // Add dates of current month
    final numberDatesOfCurrentMonth = endDateOfCurrentMonth.day;
    for (var i = 0; i < numberDatesOfCurrentMonth; i++) {
      final date = startDateOfCurrentMonth.add(
        Duration(days: i),
      );
      calendarDataList.add(
        CalendarData(
          date: date,
          isCurrentMonth: true,
          totalExpense: getTotalAmount(
            date: date,
            categoryType: CategoryType.expense,
          ),
          totalIncome: getTotalAmount(
            date: date,
            categoryType: CategoryType.income,
          ),
        ),
      );
    }

    // Add dates of next month
    final numberAddingDatesOfNextMonth =
        DateTime.sunday - endDateOfCurrentMonth.weekday;
    for (var i = 1; i <= numberAddingDatesOfNextMonth; i++) {
      final date = endDateOfCurrentMonth.startOfCurrentDate.add(
        Duration(days: i),
      );
      calendarDataList.add(
        CalendarData(
          date: date,
          isCurrentMonth: false,
          totalExpense: getTotalAmount(
            date: date,
            categoryType: CategoryType.expense,
          ),
          totalIncome: getTotalAmount(
            date: date,
            categoryType: CategoryType.income,
          ),
        ),
      );
    }

    await update(
      (state) => state.copyWith(
        calendarDataList: calendarDataList,
      ),
    );
  }

  int? getTotalAmount({
    required DateTime date,
    required CategoryType categoryType,
  }) {
    final dbRecordViewMap = state.value?.dbRecordViewMap ?? {};
    final dbRecords = dbRecordViewMap[date.startOfCurrentDate]
            ?.where((e) => e.categoryType == categoryType.index)
            .toList() ??
        [];
    if (dbRecords.isEmpty) {
      return null;
    }
    return dbRecords.map((e) => e.amount).toList().reduce(
          (value, element) => value + element,
        );
  }
}
