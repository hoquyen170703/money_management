import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/api_repository.dart';
import 'api_client_provider.dart';

part 'api_repository_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [apiClient])
ApiRepository apiRepository(ApiRepositoryRef ref) {
  return ApiRepositoryImpl(
    ref.watch(apiClientProvider),
  );
}
