import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/db_repository.dart';
import 'db_client_provider.dart';

part 'db_repository_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [dbClient])
DbRepository dbRepository(DbRepositoryRef ref) {
  return DbRepositoryImpl(
    ref.watch(dbClientProvider),
  );
}
