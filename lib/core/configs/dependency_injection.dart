import 'package:dio/dio.dart';
import 'package:expenses_off/features/expense/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/network_info.dart';

GetIt di = GetIt.instance;

Future<void> initDependecies(Dio dio, Database db) async {
  di.registerLazySingleton<Dio>(() => dio);
  di.registerLazySingleton<Database>(() => db);
  di.registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(InternetConnection()));

  await expensesInjection(dio, db);
}
