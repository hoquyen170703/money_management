import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/providers/app_language_provider.dart';
import 'string_extension.dart';

extension DateTimeExtension on DateTime {
  String toDateString({
    required String format,
    required WidgetRef ref,
  }) {
    final locale = ref.watch(appLanguageProvider).appSupportedLanguage.name;
    return DateFormat(format, locale).format(this);
  }

  DateTime get nextDate {
    return DateTime(year, month, day + 1);
  }

  DateTime get previousDate {
    return DateTime(year, month, day - 1);
  }

  DateTime get nextMonth {
    return DateTime(year, month + 1, day);
  }

  DateTime get previousMonth {
    return DateTime(year, month - 1, day);
  }

  DateTime get startDateOfCurrentMonth {
    return DateTime(year, month, 1);
  }

  DateTime get endDateOfCurrentMonth {
    final day = DateUtils.getDaysInMonth(year, month);
    return DateTime(year, month, day);
  }

  DateTime get startOfCurrentDate {
    return DateTime(year, month, day, 0, 0, 0, 0, 0);
  }

  DateTime get endOfCurrentDate {
    final startOfNextDate = nextDate.startOfCurrentDate;
    return startOfNextDate.subtract(const Duration(microseconds: 1));
  }
}
