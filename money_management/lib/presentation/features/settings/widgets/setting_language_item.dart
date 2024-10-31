import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/providers/app_language_provider.dart';
import '../../../../utilities/extensions/string_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../models/app_language.dart';

class SettingLanguageItem extends ConsumerWidget {
  const SettingLanguageItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSupportedLanguage =
        ref.watch(appLanguageProvider).appSupportedLanguage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          color: ref.colors.cellBackground,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Icon(
              Icons.text_fields,
              color: ref.colors.mainText,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              ref.appLocalizations.language,
              style: TextStyle(
                color: ref.colors.mainText,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Spacer(),
            CustomSlidingSegmentedControl<AppSupportedLanguage>(
              initialValue: appSupportedLanguage,
              children: {
                AppSupportedLanguage.vi: Text(
                  AppSupportedLanguage.vi.getTittle(ref),
                  style: TextStyle(color: ref.colors.mainText),
                ),
                AppSupportedLanguage.en: Text(
                  AppSupportedLanguage.en.getTittle(ref),
                  style: TextStyle(color: ref.colors.mainText),
                ),
              },
              decoration: BoxDecoration(
                color: ref.colors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: ref.colors.cellBackground,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              onValueChanged: (appSupportedLanguage) {
                ref
                    .read(appLanguageProvider.notifier)
                    .onChanged(appSupportedLanguage.name);
              },
              fromMax: true,
              fixedWidth: 108,
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
