import '../entities/expense.dart';
import '../repositories/i_expense_repository.dart';

class GetExpenses {
  final IExpenseRepository repository;

  GetExpenses({required this.repository});

  Future<List<Expense>> call({required int page}) async {
    return [
      Expense(
        amount: 13.50,
        created: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
        description: 'Despesa 1234',
        expenseDate: DateTime.utc(2023, 09, 02, 10, 0, 0, 123),
        id: 'asde21edsa',
        latitude: 81.121212,
        longitude: 41.232323,
        paymentReceipt:
            'https://imobiliarias.superlogica.com/hc/article_attachments/360081669333/comp..png',
      )
    ];
  }
}
