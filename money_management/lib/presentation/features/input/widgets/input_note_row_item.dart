import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../input_view_model.dart';

class InputNoteRowItem extends ConsumerWidget {
  const InputNoteRowItem({
    required this.textEditingController,
    super.key,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      color: ref.colors.cellBackground,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Text(
              ref.appLocalizations.note,
              style: TextStyle(
                color: ref.colors.mainText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: ref.colors.disable,
                    fontSize: 18,
                  ),
                  hintText: ref.appLocalizations.notePlaceholder,
                ),
                style: TextStyle(
                  color: ref.colors.mainText,
                  fontSize: 18,
                ),
                onChanged:
                    ref.watch(inputViewModelProvider.notifier).onNoteChanged,
              ),
            ),
          ),
          const SizedBox(
            width: 48,
          ),
        ],
      ),
    );
  }
}
