import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../report_view_model.dart';

class ReportStatisticRowItem extends ConsumerWidget {
  const ReportStatisticRowItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportViewModelProvider).value;
    final totalExpense = reportState?.totalExpense ?? 0;
    final totalIncome = reportState?.totalIncome ?? 0;
    final total = totalIncome - totalExpense;

    return Container(
      color: ref.colors.cellBackground,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatisticItem(
                  ref: ref,
                  title: ref.appLocalizations.expense,
                  value: totalExpense.toThousandFormatAmount(withUnit: true),
                  valueColor: Colors.red,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: _buildStatisticItem(
                  ref: ref,
                  title: ref.appLocalizations.income,
                  value: totalIncome.toThousandFormatAmount(withUnit: true),
                  valueColor: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          _buildStatisticItem(
            ref: ref,
            title: ref.appLocalizations.total,
            value:
                '${total >= 0 ? '+' : ''}${total.toThousandFormatAmount(withUnit: true)}',
            valueColor: total >= 0 ? Colors.blue : Colors.red,
            valueFontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem({
    required WidgetRef ref,
    required String title,
    required String value,
    required Color valueColor,
    double valueFontSize = 14,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: ref.colors.cellBackground,
        border: Border.all(
          color: ref.colors.tint,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: ref.colors.mainText,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: valueFontSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
