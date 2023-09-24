import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/update_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_update_sample.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final UpdateExpense updateExpense;

  setUpAll(() {
    updateExpense = UpdateExpense(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Update expense =>', () {
    test('should update expense', () async {
      when(() => mockRepository.updateExpense(
            expenseUpdate: expenseUpdateCompletedSample,
          )).thenAnswer((_) async {});

      await updateExpense(expenseUpdate: expenseUpdateCompletedSample);

      verify(() => mockRepository.updateExpense(
            expenseUpdate: expenseUpdateCompletedSample,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
