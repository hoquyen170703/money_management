import 'package:freezed_annotation/freezed_annotation.dart';

import '../db/db_category.dart';

part 'api_category.freezed.dart';

part 'api_category.g.dart';

@freezed
class ApiCategory with _$ApiCategory {
  factory ApiCategory({
    @JsonKey(name: 'en_name') required String enName,
    @JsonKey(name: 'vi_name') required String viName,
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'icon') required String icon,
    @JsonKey(name: 'color') required String color,
    @JsonKey(name: 'type') required int type,
  }) = _ApiCategory;

  factory ApiCategory.fromJson(Map<String, dynamic> json) =>
      _$ApiCategoryFromJson(json);
}

extension ApiCategoryExtension on ApiCategory {
  DbCategory get dbCategory {
    return DbCategory(
      enName: enName,
      viName: viName,
      code: code,
      icon: icon,
      color: color,
      type: type,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
