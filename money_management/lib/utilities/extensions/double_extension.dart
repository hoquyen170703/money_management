import '../../constants/constants.dart';

extension DoubleExtension on double {
  double toPrecision(int n) {
    return double.parse(toStringAsFixed(n));
  }

  String toPercent() {
    return '${toStringAsFixed(truncateToDouble() == this ? 0 : 1)}${Constants.percent}';
  }
}
