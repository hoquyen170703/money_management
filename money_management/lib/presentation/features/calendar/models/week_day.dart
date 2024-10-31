import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';

enum WeekDay {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun,
}

extension WeekDayExtension on WeekDay {
  String getTitle(WidgetRef ref) {
    switch (this) {
      case WeekDay.mon:
        return ref.appLocalizations.mon;
      case WeekDay.tue:
        return ref.appLocalizations.tue;
      case WeekDay.wed:
        return ref.appLocalizations.wed;
      case WeekDay.thu:
        return ref.appLocalizations.thu;
      case WeekDay.fri:
        return ref.appLocalizations.fri;
      case WeekDay.sat:
        return ref.appLocalizations.sat;
      case WeekDay.sun:
        return ref.appLocalizations.sun;
    }
  }

  Color getTitleColor() {
    switch (this) {
      case WeekDay.mon:
      case WeekDay.tue:
      case WeekDay.wed:
      case WeekDay.thu:
      case WeekDay.fri:
        return Colors.white;
      case WeekDay.sat:
        return Colors.blue;
      case WeekDay.sun:
        return Colors.red;
    }
  }
}
