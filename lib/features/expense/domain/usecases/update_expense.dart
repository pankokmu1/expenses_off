import '../repositories/i_expense_repository.dart';

class UpdateExpense {
  final IExpenseRepository repository;

  UpdateExpense({required this.repository});

  Future<void> call({
    required String expenseId,
    required Map<String, dynamic> expenseUpdate,
    required bool isItPending,
  }) {
    return repository.updateExpense(
      expenseId: expenseId,
      expense: expenseUpdate,
    );
  }
}
