import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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

    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
}
