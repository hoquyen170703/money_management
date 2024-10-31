import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/models/db/db_category.dart';
import '../../../../utilities/extensions/color_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../input_view_model.dart';

class InputCategoryRowItem extends ConsumerWidget {
  const InputCategoryRowItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories =
        ref.watch(inputViewModelProvider).value?.categories ?? [];
    final selectedCategoryIndex =
        ref.watch(inputViewModelProvider).value?.selectedCategoryIndex ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: ref.colors.cellBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              ref.appLocalizations.category,
              style: TextStyle(
                color: ref.colors.mainText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    ref
                        .watch(inputViewModelProvider.notifier)
                        .onSelectedCategoryIndexChanged(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: ref.colors.background,
                      border: Border.all(
                        color: selectedCategoryIndex == index
                            ? ref.colors.tint
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.network(
                            category.iconUrl,
                            width: 30,
                            height: 30,
                            colorFilter: ColorFilter.mode(
                              HexColor.fromHex(category.color),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            category.getName(ref),
                            style: TextStyle(
                              color: ref.colors.mainText,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
