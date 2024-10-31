import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/resources/app_themes.dart';
import '../data/providers/app_theme_provider.dart';
import '../data/providers/go_router_provider.dart';
import '../utilities/extensions/widget_ref_extension.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(appThemeProvider);

    return MaterialApp.router(
      title: 'Money Management',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appTheme(isDarkTheme),
      darkTheme: AppThemes.appTheme(isDarkTheme),
      themeMode: ref.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.read(goRouterProvider),
    );
  }
}
