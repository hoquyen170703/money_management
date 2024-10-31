import 'package:intl/intl.dart';

import '../../constants/constants.dart';

extension IntExtension on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  String toThousandFormatAmount({
    bool withUnit = false,
  }) {
    return "${NumberFormat('#,###').format(this)}${withUnit ? Constants.moneyUnit : ''}";
  }
}
