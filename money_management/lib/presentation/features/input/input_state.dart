import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../constants/constants.dart';
import '../../../data/models/category_type.dart';
import '../../../data/models/db/db_category.dart';

part 'input_state.freezed.dart';

@freezed
class InputState with _$InputState {
  factory InputState({
    @Default(CategoryType.expense) CategoryType categoryType,
    @Default(null) DateTime? date,
    @Default(Constants.defaultAmount) int amount,
    @Default(null) String? note,
    @Default(null) List<DbCategory>? categories,
    @Default(null) int? selectedCategoryIndex,
  }) = _InputState;
}
