abstract class IExpenseLocalDatasource {
  Future<List<Map<String, dynamic>>> getExpenses();

  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> expense,
  });
  Future<void> saveExpense({
    required Map<String, dynamic> expense,
  });
  Future<void> deleteExpense({
    required String expenseId,
  });
  Future<void> deleteAllExpenses();
}
