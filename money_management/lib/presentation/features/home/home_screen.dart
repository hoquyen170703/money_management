import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/extensions/widget_ref_extension.dart';
import '../../common_widgets/base/base_screen.dart';
import '../calendar/calendar_screen.dart';
import '../input/input_screen.dart';
import '../report/report_screen.dart';
import '../settings/setting_screen.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'models/home_tab.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  BaseScreenState createState() => _HomeScreenState();
}

class _HomeScreenState
    extends BaseScreenState<HomeScreen, HomeViewModel, HomeState>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void onInitState() {
    super.onInitState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onDispose() {
    super.onDispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0;
    });
  }

  @override
  Color? get backgroundColor => ref.colors.background;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context) {
    final selectedTabIndex =
        state.value?.selectedTabIndex ?? HomeTab.input.index;
    if (selectedTabIndex == HomeTab.input.index) {
      return const InputScreen();
    } else if (selectedTabIndex == HomeTab.calendar.index) {
      return const CalendarScreen();
    } else if (selectedTabIndex == HomeTab.report.index) {
      return const ReportScreen();
    } else if (selectedTabIndex == HomeTab.setting.index) {
      return const SettingScreen();
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    final selectedTabIndex =
        state.value?.selectedTabIndex ?? HomeTab.input.index;

    if (_isKeyboardVisible) {
      return null;
    }

    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ref.colors.tint,
        currentIndex: selectedTabIndex,
        selectedItemColor: ref.colors.white,
        unselectedItemColor: ref.colors.disable,
        onTap: viewModel.onTabChanged,
        elevation: 0,
        items: [
          _buildBottomNavigationBarItem(
            selectedTabIndex: selectedTabIndex,
            homeTab: HomeTab.input,
          ),
          _buildBottomNavigationBarItem(
            selectedTabIndex: selectedTabIndex,
            homeTab: HomeTab.calendar,
          ),
          _buildBottomNavigationBarItem(
            selectedTabIndex: selectedTabIndex,
            homeTab: HomeTab.report,
          ),
          _buildBottomNavigationBarItem(
            selectedTabIndex: selectedTabIndex,
            homeTab: HomeTab.setting,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required HomeTab homeTab,
    required int selectedTabIndex,
  }) {
    return BottomNavigationBarItem(
      label: homeTab.getTitle(ref),
      icon: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Icon(
          selectedTabIndex == homeTab.index
              ? homeTab.getSelectedIcon(ref)
              : homeTab.getUnselectedIcon(ref),
        ),
      ),
    );
  }

  @override
  AsyncValue<HomeState> get state => ref.watch(homeViewModelProvider);

  @override
  HomeViewModel get viewModel => ref.read(homeViewModelProvider.notifier);
}
