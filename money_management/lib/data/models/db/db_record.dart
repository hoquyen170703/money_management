import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data_sources/local/db/db_table.dart';
import 'db_base_model.dart';

part 'db_record.freezed.dart';

part 'db_record.g.dart';

@freezed
class DbRecord extends DbBaseModel with _$DbRecord {
  factory DbRecord({
    @JsonKey(name: DbRecordTableField.categoryId) required int categoryId,
    @JsonKey(name: DbRecordTableField.createdAt) required int createdAt,
    @JsonKey(name: DbRecordTableField.date) required int date,
    @JsonKey(name: DbRecordTableField.amount) required int amount,
    @JsonKey(name: DbRecordTableField.note) String? note,
    @JsonKey(name: DbRecordTableField.id) int? id,
    @JsonKey(name: DbRecordTableField.updatedAt) int? updatedAt,
  }) = _DbRecord;

  factory DbRecord.fromJson(Map<String, dynamic> json) =>
      _$DbRecordFromJson(json);
}
