import 'package:expenses_off/core/failures/network_failures.dart';
import 'package:expenses_off/core/utils/network_info.dart';
import 'package:expenses_off/features/expense/data/datasources/local/i_expense_local_datasource.dart';
import 'package:expenses_off/features/expense/data/datasources/remote/i_expense_remote_datasource.dart';
import 'package:expenses_off/features/expense/domain/entities/expense.dart';
import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';

class ExpenseRepository implements IExpenseRepository {
  ExpenseRepository(
    this._localDatasource,
    this._remoteDatasource,
    this._networkInfo,
  );

  final IExpenseLocalDatasource _localDatasource;
  final IExpenseRemoteDatasource _remoteDatasource;
  final INetworkInfo _networkInfo;

  @override
  Future<String> creteExpense({required Expense expense}) async {
    try {
      if (await _networkInfo.isConnected) {
        final expenseId =
            await _remoteDatasource.createExpense(expense: expense.toMap());
        return expenseId;
      } else {
        throw NoConnectionFailure();
      }
    } catch (e) {
      await _localDatasource.saveExpense(
          expense: expense.copyWith(isItPending: true).toMap());
      rethrow;
    }
  }

  @override
  Future<void> deleteExpense({
    required String expenseId,
  }) async {
    if (await _networkInfo.isConnected) {
      await _remoteDatasource.deleteExpense(expenseId: expenseId);
    } else {
      _localDatasource.deleteExpense(expenseId: expenseId);
    }
  }

  @override
  Future<String> paymentReceipt({required String expenseId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> expenses({
    required int page,
  }) async {
    late List<Map<String, dynamic>> data;
    if (await _networkInfo.isConnected) {
      data = await _remoteDatasource.getExpenses(
        page: page,
      );
    } else {
      data = await _localDatasource.getExpenses();
    }
    return data.map(Expense.fromMap).toList();
  }

  @override
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> expense,
  }) async {
    if (await _networkInfo.isConnected) {
      await _remoteDatasource.updateExpense(
        expenseId: expenseId,
        expense: expense,
      );
    } else {
      await _localDatasource.updateExpense(
        expenseId: expenseId,
        expense: expense,
      );
    }
  }

  @override
  Future<void> uploadExpensesFromCache() async {
    if (await _networkInfo.isConnected) {
      final expenses = await _localDatasource.getExpenses();
      if (expenses.isNotEmpty) {
        await _remoteDatasource.createMultipleExpense(expenses: expenses);
        await _localDatasource.deleteAllExpenses();
      }
    } else {
      throw NoConnectionFailure();
    }
  }
}
