import 'package:dio/dio.dart';
import 'package:expenses_off/core/configs/dependency_injection.dart';
import 'package:expenses_off/core/utils/network_info.dart';
import 'package:sqflite/sqflite.dart';
import 'data/datasources/local/expense_local_datasource.dart';
import 'data/datasources/local/i_expense_local_datasource.dart';
import 'data/datasources/remote/expense_remote_datasource.dart';
import 'data/datasources/remote/i_expense_remote_datasource.dart';
import 'domain/repositories/i_expense_repository.dart';
import 'domain/usecases/create_expense.dart';
import 'domain/usecases/delete_expense.dart';
import 'domain/usecases/get_expenses.dart';
import 'domain/usecases/get_payment_receipt.dart';
import 'domain/usecases/update_expense.dart';
import 'domain/usecases/upload_expenses_from_cache.dart';
import 'presentation/state_manager/expense_detail/expense_detail_cubit.dart';
import 'presentation/state_manager/expenses/expenses_cubit.dart';
import 'data/repositories/expense_repository.dart';

Future<void> expensesInjection(Dio dio, Database db) async {
  di.registerFactory<ExpensesCubit>(
      () => ExpensesCubit(di<GetExpenses>(), di<GetPaymentReceipt>()));
  di.registerFactory<ExpenseDetailCubit>(() => ExpenseDetailCubit(
      di<DeleteExpense>(), di<UpdateExpense>(), di<CreateExpense>()));

  di.registerFactory<CreateExpense>(
      () => CreateExpense(repository: di<IExpenseRepository>()));
  di.registerFactory<DeleteExpense>(
      () => DeleteExpense(repository: di<IExpenseRepository>()));
  di.registerFactory<GetExpenses>(
      () => GetExpenses(repository: di<IExpenseRepository>()));
  di.registerFactory<GetPaymentReceipt>(
      () => GetPaymentReceipt(repository: di<IExpenseRepository>()));
  di.registerFactory<UpdateExpense>(
      () => UpdateExpense(repository: di<IExpenseRepository>()));
  di.registerFactory<UploadExpensesFromCache>(
      () => UploadExpensesFromCache(repository: di<IExpenseRepository>()));

  di.registerFactory<IExpenseRepository>(() => ExpenseRepository(
        di<IExpenseLocalDatasource>(),
        di<IExpenseRemoteDatasource>(),
        di<INetworkInfo>(),
      ));

  di.registerFactory<IExpenseLocalDatasource>(() => ExpenseLocalDatasource(db));
  di.registerFactory<IExpenseRemoteDatasource>(
      () => ExpenseRemoteDatasource(dio));
}
