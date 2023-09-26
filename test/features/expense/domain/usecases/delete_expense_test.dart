import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/delete_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final DeleteExpense deleteExpense;

  setUpAll(() {
    deleteExpense = DeleteExpense(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Delete expense =>', () {
    test('should delete expense', () async {
      when(() => mockRepository.deleteExpense(
            expenseId: 'expen213id',
          )).thenAnswer((_) async {});

      await deleteExpense(
        expenseId: 'expen213id',
        isItPending: true,
      );

      verify(() => mockRepository.deleteExpense(
            expenseId: 'expen213id',
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
