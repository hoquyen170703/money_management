class CalendarData {
  const CalendarData({
    required this.date,
    required this.isCurrentMonth,
    required this.totalExpense,
    required this.totalIncome,
  });

  final DateTime date;

  final bool isCurrentMonth;

  final int? totalExpense;

  final int? totalIncome;
}
