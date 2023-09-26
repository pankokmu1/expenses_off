import 'package:expenses_off/features/expense/data/datasources/local/expense_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../fixtures/expense/sample/expense_sample.dart';

class MockDataBase extends Mock implements Database {}

void main() {
  final mockDatabase = MockDataBase();
  late ExpenseLocalDatasource localDatasource;
  final expenseMap = expenseSample.toMap();
  final expenseId = expenseSample.id;

  setUpAll(() {
    localDatasource = ExpenseLocalDatasource(mockDatabase);
  });

  tearDown(() {
    reset(mockDatabase);
  });
  group('Expense local datasource =>', () {
    test('should return expenses', () async {
      when(() => mockDatabase.query(localDatasource.tableName))
          .thenAnswer((_) async => [expenseMap]);

      final result = await localDatasource.getExpenses();

      expect(result, [expenseMap]);
      verify(() => mockDatabase.query(localDatasource.tableName));
      verifyNoMoreInteractions(mockDatabase);
    });
    test('should delete expense', () async {
      when(() => mockDatabase.delete(localDatasource.tableName,
          where: 'id = ?', whereArgs: [expenseId])).thenAnswer((_) async => 1);

      await localDatasource.deleteExpense(expenseId: expenseId);

      verify(() => mockDatabase.delete(localDatasource.tableName,
          where: 'id = ?', whereArgs: [expenseId]));
      verifyNoMoreInteractions(mockDatabase);
    });
    test('should save expense', () async {
      when(() => mockDatabase.insert(
            localDatasource.tableName,
            expenseMap,
          )).thenAnswer((_) async => 1);

      await localDatasource.saveExpense(expense: expenseMap);

      verify(() => mockDatabase.insert(
            localDatasource.tableName,
            expenseMap,
          ));
      verifyNoMoreInteractions(mockDatabase);
    });
    test('should update expense', () async {
      when(() => mockDatabase.update(
            localDatasource.tableName,
            expenseMap,
            where: 'id = ?',
            whereArgs: [expenseId],
          )).thenAnswer((_) async => 1);

      await localDatasource.updateExpense(
        expenseId: expenseId,
        expense: expenseMap,
      );

      verify(() => mockDatabase.update(
            localDatasource.tableName,
            expenseMap,
            where: 'id = ?',
            whereArgs: [expenseId],
          ));
      verifyNoMoreInteractions(mockDatabase);
    });
    test('should delete all expenses', () async {
      when(() => mockDatabase.delete(localDatasource.tableName))
          .thenAnswer((_) async => 1);

      await localDatasource.deleteAllExpenses();

      verify(() => mockDatabase.delete(localDatasource.tableName));
      verifyNoMoreInteractions(mockDatabase);
    });
  });
}
