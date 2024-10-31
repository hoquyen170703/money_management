import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/extensions/widget_ref_extension.dart';

enum CategoryType {
  expense, // Khoản chi
  income, // Khoản thu
}

extension CategoryTypeExtension on CategoryType {
  String getTitle(WidgetRef ref) {
    switch (this) {
      case CategoryType.expense:
        return ref.appLocalizations.expense;
      case CategoryType.income:
        return ref.appLocalizations.income;
    }
  }

  Color getTitleColor() {
    switch (this) {
      case CategoryType.expense:
        return Colors.red;
      case CategoryType.income:
        return Colors.blue;
    }
  }
}
