import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/category_type.dart';
import '../../../data/models/db/db_category.dart';
import '../../../data/models/db/db_record_view.dart';
import '../../../data/providers/db_repository_provider.dart';
import '../../../utilities/extensions/date_time_extension.dart';
import '../../../utilities/extensions/double_extension.dart';
import 'models/chart_data.dart';
import 'report_state.dart';

part 'report_view_model.g.dart';

@Riverpod(dependencies: [dbRepository])
class ReportViewModel extends _$ReportViewModel {
  @override
  FutureOr<ReportState> build() {
    return ReportState(date: DateTime.now());
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

    await update(
      (state) => state.copyWith(
        expenseChartDataList: _getChartData(
          dbRecordViewList: dbRecordViewList,
          categoryType: CategoryType.expense,
        ),
        incomeChartDataList: _getChartData(
          dbRecordViewList: dbRecordViewList,
          categoryType: CategoryType.income,
        ),
        totalIncome: _getTotalAmount(
          dbRecordViewList: dbRecordViewList,
          categoryType: CategoryType.income,
        ),
        totalExpense: _getTotalAmount(
          dbRecordViewList: dbRecordViewList,
          categoryType: CategoryType.expense,
        ),
      ),
    );
  }

  List<ChartData> _getChartData({
    required List<DbRecordView> dbRecordViewList,
    required CategoryType categoryType,
  }) {
    final charDataList = <ChartData>[];
    final dbRecordViewMap = <DbCategory, List<DbRecordView>>{};
    final filteredDbRecordViewList = dbRecordViewList.where(
      (element) => element.categoryType == categoryType.index,
    );
    final totalAmount = filteredDbRecordViewList.map((e) => e.amount).sum;
    for (final dbRecordView in filteredDbRecordViewList) {
      (dbRecordViewMap[dbRecordView.dbCategory] ??= []).add(dbRecordView);
    }
    var remainingPercent = 100.0;
    final sortedKeys =
        dbRecordViewMap.keys.toList().sorted((category1, category2) {
      final category1Id = category1.id ?? 0;
      final category2Id = category2.id ?? 0;
      return category1Id.compareTo(category2Id);
    });
    for (var index = 0; index < sortedKeys.length; index++) {
      final key = sortedKeys[index];
      final dbRecordViewList = dbRecordViewMap[key] ?? [];
      final amount = dbRecordViewList.map((e) => e.amount).sum;
      final percent = (amount / totalAmount * 100).toPrecision(1);
      if (index == sortedKeys.length - 1) {
        charDataList.add(
          ChartData(key, remainingPercent.toPrecision(1), amount),
        );
      } else {
        charDataList.add(
          ChartData(key, percent, amount),
        );
        remainingPercent -= percent;
      }
    }

    return charDataList;
  }

  int _getTotalAmount({
    required List<DbRecordView> dbRecordViewList,
    required CategoryType categoryType,
  }) {
    if (dbRecordViewList.isEmpty) {
      return 0;
    }
    return dbRecordViewList
        .where((element) => element.categoryType == categoryType.index)
        .map((e) => e.amount)
        .toList()
        .fold(0, (value, element) => value + element);
  }
}
