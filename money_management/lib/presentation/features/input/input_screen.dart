import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/routes.dart';
import '../../../data/models/category_type.dart';
import '../../../data/providers/go_router_provider.dart';
import '../../../utilities/extensions/widget_ref_extension.dart';
import '../../common_widgets/base/base_screen.dart';
import 'input_state.dart';
import 'input_view_model.dart';
import 'widgets/input_amount_row_item.dart';
import 'widgets/input_category_row_item.dart';
import 'widgets/input_date_row_item.dart';
import 'widgets/input_note_row_item.dart';
import 'widgets/input_type_row_item.dart';

class InputScreen extends BaseScreen {
  const InputScreen({super.key});

  @override
  BaseScreenState createState() => _InputScreenState();
}

class _InputScreenState
    extends BaseScreenState<InputScreen, InputViewModel, InputState> {
  final TextEditingController _amountTextEditingController =
      TextEditingController(
    text: Constants.defaultAmount.toString(),
  );

  final TextEditingController _noteTextEditingController =
      TextEditingController();

  @override
  void onInitState() {
    super.onInitState();
    _onInit();
  }

  @override
  void onDispose() {
    super.onDispose();
    _amountTextEditingController.dispose();
    _noteTextEditingController.dispose();
  }

  Future<void> _onInit() async {
    await viewModel.insertDefaultCategoriesIfNeeded();
    await viewModel.getCategories();
  }

  @override
  Color? get backgroundColor => ref.colors.background;

  @override
  bool get tapOutsideHideKeyboard => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    final categoryType = state.value?.categoryType ?? CategoryType.expense;
    return AppBar(
      title: Text(
        categoryType.getTitle(ref),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final horizontalDivider = Container(
      height: 0.5,
      color: ref.colors.disable,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              const InputDateRowItem(),
              horizontalDivider,
              InputAmountRowItem(
                textEditingController: _amountTextEditingController,
              ),
              horizontalDivider,
              InputNoteRowItem(
                textEditingController: _noteTextEditingController,
              ),
              horizontalDivider,
              const InputTypeRowItem(),
              horizontalDivider,
              const InputCategoryRowItem(),
            ],
          ),
        ),
        horizontalDivider,
        Container(
          color: ref.colors.cellBackground,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ref.colors.tint,
              foregroundColor: Colors.white,
              surfaceTintColor: ref.colors.tint,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await viewModel.onSave();
              ref.read(goRouterProvider).goNamed(RouteNames.inputComplete);
              _clearState();
            },
            child: Text(
              ref.appLocalizations.save,
            ),
          ),
        ),
      ],
    );
  }

  void _clearState() {
    _amountTextEditingController.text = Constants.defaultAmount.toString();
    _noteTextEditingController.text = '';
  }

  @override
  AsyncValue<InputState> get state => ref.watch(inputViewModelProvider);

  @override
  InputViewModel get viewModel => ref.read(inputViewModelProvider.notifier);
}
