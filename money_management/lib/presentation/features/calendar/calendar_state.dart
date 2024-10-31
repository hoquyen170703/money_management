import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/db/db_record_view.dart';
import 'models/calendar_data.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  factory CalendarState({
    @Default(null) DateTime? date,
    @Default(null) DateTime? startDateOfCurrentMonth,
    @Default(null) DateTime? endDateOfCurrentMonth,
    @Default(null) List<CalendarData>? calendarDataList,
    @Default(null) Map<DateTime, List<DbRecordView>>? dbRecordViewMap,
    @Default(null) List<DbRecordView>? dbRecordViewList,
  }) = _CalendarState;
}
