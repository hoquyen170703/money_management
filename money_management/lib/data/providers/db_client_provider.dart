import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data_sources/local/db/db_client.dart';

part 'db_client_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
DbClient dbClient(DbClientRef ref) {
  return DbClient();
}
