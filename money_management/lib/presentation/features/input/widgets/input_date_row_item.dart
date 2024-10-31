import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../utilities/extensions/date_time_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../input_view_model.dart';

class InputDateRowItem extends ConsumerWidget {
  const InputDateRowItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(inputViewModelProvider).value?.date;

    return Container(
      height: 64,
      color: ref.colors.cellBackground,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  ref.appLocalizations.date,
                  style: TextStyle(
                    color: ref.colors.mainText,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    ref.read(inputViewModelProvider.notifier).onPreviousDate();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: ref.colors.mainText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: GestureDetector(
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ref.colors.background,
                  ),
                  child: Center(
                    child: Text(
                      date?.toDateString(
                            format: Constants.dayFormat,
                            ref: ref,
                          ) ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ref.colors.mainText,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(inputViewModelProvider.notifier).onNextDate();
            },
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                Icons.arrow_forward_ios,
                color: ref.colors.mainText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
