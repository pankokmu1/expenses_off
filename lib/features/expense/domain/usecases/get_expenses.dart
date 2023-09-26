import '../entities/expense.dart';
import '../repositories/i_expense_repository.dart';

class GetExpenses {
  final IExpenseRepository repository;

  GetExpenses({required this.repository});

  Future<List<Expense>> call({required int page}) {
    return repository.expenses(page: page);
  }
}
