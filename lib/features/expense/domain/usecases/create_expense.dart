import '../entities/expense.dart';
import '../repositories/i_expense_repository.dart';

class CreateExpense {
  final IExpenseRepository repository;

  CreateExpense({required this.repository});

  Future<void> call({required Expense expense}) {
    return repository.creteExpense(expense: expense);
  }
}
