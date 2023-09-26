import '../entities/expense.dart';
import '../repositories/i_expense_repository.dart';
import 'get_expenses.dart';

class UploadExpensesFromCache {
  final IExpenseRepository repository;

  UploadExpensesFromCache({required this.repository});

  Future<List<Expense>> call() async {
    await repository.uploadExpensesFromCache();

    final getExpenses = GetExpenses(repository: repository);
    return getExpenses(page: 1);
  }
}
