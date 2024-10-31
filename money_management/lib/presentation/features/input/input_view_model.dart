import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/constants.dart';
import '../../../data/models/api/api_category.dart';
import '../../../data/models/category_type.dart';
import '../../../data/models/db/db_record.dart';
import '../../../data/providers/api_repository_provider.dart';
import '../../../data/providers/db_repository_provider.dart';
import '../../../utilities/extensions/date_time_extension.dart';
import 'input_state.dart';

part 'input_view_model.g.dart';

@Riverpod(dependencies: [dbRepository, apiRepository])
class InputViewModel extends _$InputViewModel {
  @override
  FutureOr<InputState> build() {
    return InputState(date: DateTime.now().startOfCurrentDate);
  }

  Future<void> onCategoryTypeChanged(CategoryType categoryType) async {
    await update(
      (state) => state.copyWith(
        categoryType: categoryType,
      ),
    );
    await getCategories();
  }

  void onNextDate() {
    final date = state.value?.date ?? DateTime.now();
    update(
      (state) => state.copyWith(
        date: date.nextDate,
      ),
    );
  }

  void onPreviousDate() {
    final date = state.value?.date ?? DateTime.now();
    update(
      (state) => state.copyWith(
        date: date.previousDate,
      ),
    );
  }

  Future<void> getCategories() async {
    final categoryType = state.value?.categoryType;
    final categories = await ref.read(dbRepositoryProvider).getDbCategories(
          categoryType: categoryType,
        );
    await update(
      (state) => state.copyWith(
        categories: categories,
        selectedCategoryIndex: categories.isNotEmpty ? 0 : null,
      ),
    );
  }

  void onSelectedCategoryIndexChanged(int index) {
    update(
      (state) => state.copyWith(
        selectedCategoryIndex: index,
      ),
    );
  }

  void onAmountChanged(int amount) {
    update(
      (state) => state.copyWith(
        amount: amount,
      ),
    );
  }

  void onNoteChanged(String note) {
    update(
      (state) => state.copyWith(
        note: note,
      ),
    );
  }

  Future<void> onSave() async {
    final categories = state.value?.categories ?? [];
    if (categories.isEmpty) {
      return;
    }
    final selectedCategoryIndex = state.value?.selectedCategoryIndex;
    if (selectedCategoryIndex == null) {
      return;
    }
    final selectedCategory = categories[selectedCategoryIndex];
    final selectedCategoryId = selectedCategory.id;
    if (selectedCategoryId == null) {
      return;
    }
    final date = state.value?.date;
    if (date == null) {
      return;
    }
    final amount = state.value?.amount;
    if (amount == null) {
      return;
    }
    final note = state.value?.note;
    final dbRecord = DbRecord(
      categoryId: selectedCategoryId,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      date: date.millisecondsSinceEpoch,
      amount: amount,
      note: note,
    );
    await ref.read(dbRepositoryProvider).insertDbRecord(dbRecord: dbRecord);
    clearState();
  }

  void clearState() {
    update(
      (state) => state.copyWith(
        amount: Constants.defaultAmount,
        note: null,
      ),
    );
  }

  Future<void> insertDefaultCategoriesIfNeeded() async {
    final currentDbCategories =
        await ref.read(dbRepositoryProvider).getDbCategories();
    if (currentDbCategories.isNotEmpty) {
      return;
    }
    final categories = await ref.read(apiRepositoryProvider).getCategories();
    final dbCategories = categories.map((category) => category.dbCategory).toList();
    await ref
        .read(dbRepositoryProvider)
        .insertDbCategories(dbCategories: dbCategories);
  }
}
