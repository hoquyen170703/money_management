import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/models/category_type.dart';
import '../../../../data/models/db/db_category.dart';
import '../../../../utilities/extensions/color_extension.dart';
import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/num_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../models/chart_data.dart';
import '../report_view_model.dart';
import 'report_chart_category_list_item.dart';

class ReportChartView extends ConsumerWidget {
  const ReportChartView({
    required this.categoryType,
    super.key,
  });

  final CategoryType categoryType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartDataList = _getChartData(ref: ref);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 2 / 3,
            color: ref.colors.cellBackground,
            child: SfCircularChart(
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartDataList,
                  pointColorMapper: (data, _) =>
                      HexColor.fromHex(data.dbCategory.color),
                  xValueMapper: (data, _) => data.dbCategory.getName(ref),
                  yValueMapper: (data, _) => data.percent,
                  dataLabelMapper: (data, _) => data.percent.toPercent(),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    textStyle: TextStyle(color: ref.colors.mainText),
                  ),
                ),
              ],
              tooltipBehavior: _buildTooltipBehavior(ref),
              legend: _buildLegend(ref),
            ),
          ),
          Container(
            height: 0.5,
            color: ref.colors.disable,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ReportChartCategoryListItem(
                chartData: chartDataList[index],
              );
            },
            itemCount: chartDataList.length,
          ),
        ],
      ),
    );
  }

  Legend _buildLegend(WidgetRef ref) {
    return Legend(
      isVisible: true,
      position: LegendPosition.bottom,
      overflowMode: LegendItemOverflowMode.wrap,
      textStyle: TextStyle(color: ref.colors.mainText),
      toggleSeriesVisibility: false,
    );
  }

  TooltipBehavior _buildTooltipBehavior(WidgetRef ref) {
    return TooltipBehavior(
      enable: true,
      builder: (data, point, _, __, ___) {
        final chartData = data as ChartData;
        return Container(
          decoration: BoxDecoration(
            color: ref.colors.tint,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                point.x,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Text(
                chartData.totalAmount.toThousandFormatAmount(withUnit: true),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                point.y?.toPercent() ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<ChartData> _getChartData({
    required WidgetRef ref,
  }) {
    switch (categoryType) {
      case CategoryType.expense:
        return ref.watch(reportViewModelProvider).value?.expenseChartDataList ??
            [];
      case CategoryType.income:
        return ref.watch(reportViewModelProvider).value?.incomeChartDataList ??
            [];
    }
  }
}
