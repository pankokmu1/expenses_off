import '../repositories/i_expense_repository.dart';

class DeleteExpense {
  final IExpenseRepository repository;

  DeleteExpense({required this.repository});

  Future<void> call({required String expenseId}) {
    assert(expenseId.isNotEmpty);

    return repository.deleteExpense(expenseId: expenseId);
  }
}
