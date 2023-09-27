import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dependency_injection.dart';

part 'http_client_configs.dart';
part 'persistence_configs.dart';

class AppConfig {
  static Future<void> init() async {
    final httpClientConfig = HttpClientConfigs._();
    final persistenceConfigs = PersistenceConfigs._();

    await httpClientConfig._init();
    await persistenceConfigs._init();

    final dio = httpClientConfig.client;
    final sqflite = persistenceConfigs.persistence;

    await initDependecies(dio, sqflite);
  }
}
