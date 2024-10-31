import 'package:freezed_annotation/freezed_annotation.dart';

import 'models/chart_data.dart';

part 'report_state.freezed.dart';

@freezed
class ReportState with _$ReportState {
  factory ReportState({
    @Default(null) DateTime? date,
    @Default(null) DateTime? startDateOfCurrentMonth,
    @Default(null) DateTime? endDateOfCurrentMonth,
    @Default(null) int? totalExpense,
    @Default(null) int? totalIncome,
    @Default(null) List<ChartData>? expenseChartDataList,
    @Default(null) List<ChartData>? incomeChartDataList,
  }) = _ReportState;
}
