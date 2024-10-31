import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/models/category_type.dart';
import '../../../../data/models/db/db_record_view.dart';
import '../../../../utilities/extensions/color_extension.dart';
import '../../../../utilities/extensions/int_extension.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';

class CalendarRecordListViewItem extends ConsumerWidget {
  const CalendarRecordListViewItem({
    required this.dbRecordView,
    super.key,
  });

  final DbRecordView dbRecordView;

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
                dbRecordView.iconUrl,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  HexColor.fromHex(dbRecordView.categoryColor),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                dbRecordView.getName(ref),
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
                  (dbRecordView.note?.isNotEmpty ?? false)
                      ? '(${dbRecordView.note})'
                      : '',
                  style: TextStyle(
                    color: ref.colors.mainText,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                dbRecordView.amount.toThousandFormatAmount(withUnit: true),
                style: TextStyle(
                  color: dbRecordView.getCategoryType().getTitleColor(),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
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
