import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../constants/constants.dart';
import '../../../presentation/features/settings/models/app_language.dart';
import '../../../utilities/extensions/string_extension.dart';
import '../../data_sources/local/db/db_table.dart';
import '../../providers/app_language_provider.dart';
import 'db_base_model.dart';

part 'db_category.freezed.dart';

part 'db_category.g.dart';

@freezed
class DbCategory extends DbBaseModel with _$DbCategory {
  factory DbCategory({
    @JsonKey(name: DbCategoryTableField.enName) required String enName,
    @JsonKey(name: DbCategoryTableField.viName) required String viName,
    @JsonKey(name: DbCategoryTableField.code) required String code,
    @JsonKey(name: DbCategoryTableField.icon) required String icon,
    @JsonKey(name: DbCategoryTableField.color) required String color,
    @JsonKey(name: DbCategoryTableField.type) required int type,
    @JsonKey(name: DbCategoryTableField.createdAt) required int createdAt,
    @JsonKey(name: DbCategoryTableField.id) int? id,
    @JsonKey(name: DbCategoryTableField.updatedAt) int? updatedAt,
  }) = _DbCategory;

  factory DbCategory.fromJson(Map<String, dynamic> json) =>
      _$DbCategoryFromJson(json);
}

extension DbCategoryExtension on DbCategory {
  String getName(WidgetRef ref) {
    final appSupportedLanguage =
        ref.watch(appLanguageProvider).appSupportedLanguage;
    switch (appSupportedLanguage) {
      case AppSupportedLanguage.vi:
        return viName;
      case AppSupportedLanguage.en:
        return enName;
    }
  }

  String get iconUrl {
    return Constants.baseUrl + icon;
  }
}
