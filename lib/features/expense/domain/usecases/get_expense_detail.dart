import '../entities/expense.dart';
import '../repositories/i_expense_repository.dart';

class GetExpenseDetail {
  final IExpenseRepository repository;

  GetExpenseDetail({required this.repository});

  Stream<Expense> call({required String expenseId}) async* {
    assert(expenseId.isNotEmpty);

    final result = repository.expenseDetail(expenseId: expenseId);

    await for (final (expense, paymentReceipt) in result) {
      yield expense.copyWith(paymentReceipt: paymentReceipt);
    }
  }
}
