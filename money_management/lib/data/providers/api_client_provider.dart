import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/constants.dart';
import '../data_sources/remote/api/api_client.dart';
import '../data_sources/remote/api/api_config.dart';
import 'dio_provider.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [dio])
ApiClient apiClient(ApiClientRef ref) {
  return ApiClient(
    ref.watch(dioProvider),
    baseUrl: ApiConfig(Constants.baseUrl).apiUrl,
  );
}
