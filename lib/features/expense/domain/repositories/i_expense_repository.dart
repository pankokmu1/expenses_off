import '../entities/expense.dart';
import '../entities/expense_summary.dart';
import '../entities/expense_update.dart';

abstract class IExpenseRepository {
  Stream<List<ExpenseSummary>> expensesSummaries();
  Stream<(Expense, String?)> expenseDetail({required String expenseId});
  Future<void> creteExpense({required Expense expense});
  Future<void> updateExpense({required ExpenseUpdate expenseUpdate});
  Future<void> deleteExpense({required String expenseId});
}
