import '../entities/expense_update.dart';
import '../repositories/i_expense_repository.dart';

class UpdateExpense {
  final IExpenseRepository repository;

  UpdateExpense({required this.repository});

  Future<void> call({required ExpenseUpdate expenseUpdate}) {
    return repository.updateExpense(expenseUpdate: expenseUpdate);
  }
}
