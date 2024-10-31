import '../../constants/constants.dart';

extension NumExtension on num {
  double toPrecision(int n) {
    return double.parse(toStringAsFixed(n));
  }

  String toPercent() {
    return '${toStringAsFixed(truncateToDouble() == this ? 0 : 1)}${Constants.percent}';
  }
}
