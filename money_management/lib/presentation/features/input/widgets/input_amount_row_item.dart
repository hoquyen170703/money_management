import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../input_view_model.dart';

class InputAmountRowItem extends ConsumerWidget {
  const InputAmountRowItem({
    required this.textEditingController,
    super.key,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: Text(
              ref.appLocalizations.amount,
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
                controller: textEditingController,
                inputFormatters: [
                  ThousandsFormatter(),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  filled: true,
                  fillColor: ref.colors.background,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ref.colors.disable,
                    fontSize: 24,
                  ),
                  hintText: Constants.defaultAmount.toString(),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ref.colors.mainText,
                  fontSize: 24,
                ),
                onChanged: (value) {
                  ref.read(inputViewModelProvider.notifier).onAmountChanged(
                        int.tryParse(
                              value.replaceAll(
                                Constants.amountThousandSeparator,
                                '',
                              ),
                            ) ??
                            Constants.defaultAmount,
                      );
                },
              ),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Text(
                Constants.moneyUnit,
                style: TextStyle(
                  color: ref.colors.mainText,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formattedValue = _formatter.format(
      int.tryParse(
            newValue.text.replaceAll(Constants.amountThousandSeparator, ''),
          ) ??
          Constants.defaultAmount,
    );

    final selectionOffset = newValue.selection.baseOffset +
        (formattedValue.length - newValue.text.length);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: selectionOffset),
    );
  }
}
