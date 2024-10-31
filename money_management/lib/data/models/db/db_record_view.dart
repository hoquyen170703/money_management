import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../constants/constants.dart';
import '../../../presentation/features/settings/models/app_language.dart';
import '../../../utilities/extensions/string_extension.dart';
import '../../data_sources/local/db/db_table.dart';
import '../../providers/app_language_provider.dart';
import '../category_type.dart';
import 'db_base_model.dart';
import 'db_category.dart';

part 'db_record_view.freezed.dart';

part 'db_record_view.g.dart';

@freezed
class DbRecordView extends DbBaseModel with _$DbRecordView {
  factory DbRecordView({
    @JsonKey(name: DbRecordViewField.categoryId) required int categoryId,
    @JsonKey(name: DbRecordViewField.createdAt) required int createdAt,
    @JsonKey(name: DbRecordViewField.date) required int date,
    @JsonKey(name: DbRecordViewField.amount) required int amount,
    @JsonKey(name: DbRecordViewField.id) required int id,
    @JsonKey(name: DbRecordViewField.categoryEnName)
    required String categoryEnName,
    @JsonKey(name: DbRecordViewField.categoryViName)
    required String categoryViName,
    @JsonKey(name: DbRecordViewField.categoryCode) required String categoryCode,
    @JsonKey(name: DbRecordViewField.categoryIcon) required String categoryIcon,
    @JsonKey(name: DbRecordViewField.categoryColor)
    required String categoryColor,
    @JsonKey(name: DbRecordViewField.categoryType) required int categoryType,
    @JsonKey(name: DbRecordViewField.categoryCreatedAt)
    required int categoryCreatedAt,
    @JsonKey(name: DbRecordViewField.note) String? note,
    @JsonKey(name: DbRecordViewField.updatedAt) int? updatedAt,
    @JsonKey(name: DbRecordViewField.categoryUpdatedAt) int? categoryUpdatedAt,
  }) = _DbRecordView;

  factory DbRecordView.fromJson(Map<String, dynamic> json) =>
      _$DbRecordViewFromJson(json);
}

extension DbRecordViewExtension on DbRecordView {
  DbCategory get dbCategory {
    return DbCategory(
      enName: categoryEnName,
      viName: categoryViName,
      code: categoryCode,
      icon: categoryIcon,
      color: categoryColor,
      type: categoryType,
      createdAt: categoryCreatedAt,
      updatedAt: categoryUpdatedAt,
    );
  }

  String getName(WidgetRef ref) {
    final appSupportedLanguage =
        ref.watch(appLanguageProvider).appSupportedLanguage;
    switch (appSupportedLanguage) {
      case AppSupportedLanguage.vi:
        return categoryViName;
      case AppSupportedLanguage.en:
        return categoryEnName;
    }
  }

  CategoryType getCategoryType() {
    if (categoryType == CategoryType.income.index) {
      return CategoryType.income;
    } else {
      return CategoryType.expense;
    }
  }

  String get iconUrl {
    return Constants.baseUrl + categoryIcon;
  }
}
