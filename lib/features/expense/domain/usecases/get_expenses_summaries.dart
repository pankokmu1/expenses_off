import '../entities/expense_summary.dart';
import '../repositories/i_expense_repository.dart';

class GetExpensesSummaries {
  final IExpenseRepository repository;

  GetExpensesSummaries({required this.repository});

  Stream<List<ExpenseSummary>> call() {
    return repository.expensesSummaries();
  }
}
