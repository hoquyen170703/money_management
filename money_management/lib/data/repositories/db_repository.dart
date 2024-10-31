import '../data_sources/local/db/db_client.dart';
import '../models/category_type.dart';
import '../models/db/db_category.dart';
import '../models/db/db_record.dart';
import '../models/db/db_record_view.dart';

abstract class DbRepository {
  Future<int?> insertDbRecord({
    required DbRecord dbRecord,
  });

  Future<int?> insertDbCategory({
    required DbCategory dbCategory,
  });

  Future<List<DbCategory>> getDbCategories({
    CategoryType? categoryType,
  });

  Future<void> insertDbCategories({
    required List<DbCategory> dbCategories,
  });

  Future<List<DbRecordView>> getDbRecords({
    required DateTime startDate,
    required DateTime endDate,
  });
}

class DbRepositoryImpl implements DbRepository {
  DbRepositoryImpl(
    this._dbClient,
  );

  final DbClient _dbClient;

  @override
  Future<int?> insertDbCategory({
    required DbCategory dbCategory,
  }) {
    return _dbClient.insertDbCategory(dbCategory: dbCategory);
  }

  @override
  Future<int?> insertDbRecord({
    required DbRecord dbRecord,
  }) {
    return _dbClient.insertDbRecord(dbRecord: dbRecord);
  }

  @override
  Future<List<DbCategory>> getDbCategories({
    CategoryType? categoryType,
  }) async {
    final maps = await _dbClient.getDbCategories(categoryType: categoryType);
    return maps.map((map) => DbCategory.fromJson(map)).toList();
  }

  @override
  Future<void> insertDbCategories({required List<DbCategory> dbCategories}) {
    return _dbClient.insertCategories(dbCategories: dbCategories);
  }

  @override
  Future<List<DbRecordView>> getDbRecords({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final maps = await _dbClient.getDbRecords(
      startDate: startDate,
      endDate: endDate,
    );
    return maps.map((map) => DbRecordView.fromJson(map)).toList();
  }
}
