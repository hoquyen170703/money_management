import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/category_type.dart';
import '../../../utilities/extensions/widget_ref_extension.dart';
import '../../common_widgets/base/base_screen.dart';
import 'report_state.dart';
import 'report_view_model.dart';
import 'widgets/report_chart_view.dart';
import 'widgets/report_date_row_item.dart';
import 'widgets/report_statistic_row_item.dart';

class ReportScreen extends BaseScreen {
  const ReportScreen({super.key});

  @override
  BaseScreenState createState() => _ReportScreenState();
}

class _ReportScreenState
    extends BaseScreenState<ReportScreen, ReportViewModel, ReportState> {
  @override
  Color? get backgroundColor => ref.colors.background;

  @override
  void onInitState() {
    super.onInitState();
    viewModel.init();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        ref.appLocalizations.report,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: buildScreen(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const ReportDateRowItem(),
        const ReportStatisticRowItem(),
        Material(
          color: ref.colors.cellBackground,
          child: TabBar(
            labelColor: ref.colors.tabBarSelectedColor,
            unselectedLabelColor: ref.colors.disable,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ref.colors.tabBarSelectedColor,
            dividerColor: ref.colors.disable,
            indicatorWeight: 4,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: [
              Tab(text: CategoryType.expense.getTitle(ref)),
              Tab(text: CategoryType.income.getTitle(ref)),
            ],
          ),
        ),
        const Expanded(
          child: TabBarView(
            children: [
              ReportChartView(categoryType: CategoryType.expense),
              ReportChartView(categoryType: CategoryType.income),
            ],
          ),
        ),
      ],
    );
  }

  @override
  AsyncValue<ReportState> get state => ref.watch(reportViewModelProvider);

  @override
  ReportViewModel get viewModel => ref.read(reportViewModelProvider.notifier);
}
