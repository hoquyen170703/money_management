import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';

enum AppSupportedLanguage {
  en,
  vi,
}

extension AppSupportedLanguageExtension on AppSupportedLanguage {
  Locale get locale {
    switch (this) {
      case AppSupportedLanguage.en:
        return const Locale('en');
      case AppSupportedLanguage.vi:
        return const Locale('vi');
    }
  }

  String getTittle(WidgetRef ref) {
    switch (this) {
      case AppSupportedLanguage.vi:
        return ref.appLocalizations.vietnamese;
      case AppSupportedLanguage.en:
        return ref.appLocalizations.english;
    }
  }
}
