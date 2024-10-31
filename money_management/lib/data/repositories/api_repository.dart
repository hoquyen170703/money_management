import '../data_sources/remote/api/api_client.dart';
import '../models/api/api_category.dart';

abstract class ApiRepository {
  Future<List<ApiCategory>> getCategories();
}

class ApiRepositoryImpl implements ApiRepository {
  ApiRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<List<ApiCategory>> getCategories() {
    return _apiClient.getCategories();
  }
}
