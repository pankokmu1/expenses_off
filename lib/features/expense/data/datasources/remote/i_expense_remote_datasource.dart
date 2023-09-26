abstract class IExpenseRemoteDatasource {
  Future<String> createExpense({
    required Map<String, dynamic> expense,
  });
  Future<void> createMultipleExpense({
    required List<Map<String, dynamic>> expenses,
  });
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> expense,
  });
  Future<void> deleteExpense({required String expenseId});

  Future<List<Map<String, dynamic>>> getExpenses({required int page});

  Future<void> getPaymentReceipt({required String expenseId});
}
