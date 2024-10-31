import '../../../../data/models/db/db_category.dart';

class ChartData {
  ChartData(
    this.dbCategory,
    this.percent,
    this.totalAmount,
  );

  final DbCategory dbCategory;

  final double percent;

  final int totalAmount;
}
