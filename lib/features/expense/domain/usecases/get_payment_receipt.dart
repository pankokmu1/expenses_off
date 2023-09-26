import '../repositories/i_expense_repository.dart';

class GetPaymentReceipt {
  final IExpenseRepository repository;

  GetPaymentReceipt({required this.repository});

  Future<String> call({
    required String expenseId,
  }) {
    return repository.paymentReceipt(expenseId: expenseId);
  }
}
