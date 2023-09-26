import '../entities/expense.dart';

abstract class IExpenseRepository {
  Future<void> creteExpense({required Expense expense});
  Future<void> deleteExpense({required String expenseId});
  Future<List<Expense>> expenses({required int page});
  Future<String> paymentReceipt({required String expenseId});
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> expense,
  });
  Future<void> uploadExpensesFromCache();
}
