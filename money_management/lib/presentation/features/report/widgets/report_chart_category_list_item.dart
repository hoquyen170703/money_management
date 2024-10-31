import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/models/db/db_category.dart';
import '../../../../utilities/extensions/color_extension.dart';
import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/num_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';
import '../models/chart_data.dart';

class ReportChartCategoryListItem extends ConsumerWidget {
  const ReportChartCategoryListItem({
    required this.chartData,
    super.key,
  });

  final ChartData chartData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          height: 48,
          color: ref.colors.cellBackground,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              SvgPicture.network(
                chartData.dbCategory.iconUrl,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  HexColor.fromHex(chartData.dbCategory.color),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                chartData.dbCategory.getName(ref),
                style: TextStyle(
                  color: ref.colors.mainText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  chartData.totalAmount.toThousandFormatAmount(withUnit: true),
                  style: TextStyle(
                    color: ref.colors.mainText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 48,
                child: Text(
                  chartData.percent.toPercent(),
                  style: TextStyle(
                    color: ref.colors.mainText,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ref.colors.mainText,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: ref.colors.disable,
          height: 0.5,
        ),
      ],
    );
  }
}
