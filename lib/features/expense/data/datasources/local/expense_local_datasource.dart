import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'i_expense_local_datasource.dart';

class ExpenseLocalDatasource implements IExpenseLocalDatasource {
  ExpenseLocalDatasource(this._database);

  final Database _database;

  @visibleForTesting
  final tableName = 'expense';

  @override
  Future<List<Map<String, dynamic>>> getExpenses() async {
    return await _database.query(tableName);
  }

  @override
  Future<void> deleteExpense({required String expenseId}) async {
    await _database.delete(tableName, where: 'id = ?', whereArgs: [expenseId]);
  }

  @override
  Future<void> saveExpense({required Map<String, dynamic> expense}) async {
    await _database.insert(tableName, expense);
  }

  @override
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> expense,
  }) async {
    await _database.update(
      tableName,
      expense,
      where: 'id = ?',
      whereArgs: [expenseId],
    );
  }

  @override
  Future<void> deleteAllExpenses() async {
    await _database.delete(tableName);
  }
}
