import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';

enum HomeTab {
  input,
  calendar,
  report,
  setting,
}

extension HomeTabExtension on HomeTab {
  String getTitle(WidgetRef ref) {
    switch (this) {
      case HomeTab.input:
        return ref.appLocalizations.input;
      case HomeTab.calendar:
        return ref.appLocalizations.calendar;
      case HomeTab.report:
        return ref.appLocalizations.report;
      case HomeTab.setting:
        return ref.appLocalizations.setting;
    }
  }

  IconData getSelectedIcon(WidgetRef ref) {
    switch (this) {
      case HomeTab.input:
        return Icons.add_box;
      case HomeTab.calendar:
        return Icons.calendar_month;
      case HomeTab.report:
        return Icons.pie_chart;
      case HomeTab.setting:
        return Icons.settings;
    }
  }

  IconData getUnselectedIcon(WidgetRef ref) {
    switch (this) {
      case HomeTab.input:
        return Icons.add_box_outlined;
      case HomeTab.calendar:
        return Icons.calendar_month_outlined;
      case HomeTab.report:
        return Icons.pie_chart_outline;
      case HomeTab.setting:
        return Icons.settings_outlined;
    }
  }
}
