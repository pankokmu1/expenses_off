import 'package:expenses_off/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:expenses_off/features/expense/domain/usecases/create_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/expense/sample/expense_sample.dart';

class MockRepository extends Mock implements IExpenseRepository {}

void main() {
  final mockRepository = MockRepository();
  late final CreateExpense createExpense;

  setUpAll(() {
    createExpense = CreateExpense(repository: mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Create expense =>', () {
    test('should create expense', () async {
      when(() => mockRepository.creteExpense(expense: expenseSample))
          .thenAnswer((_) async => 'url.com');

      final result = await createExpense(expense: expenseSample);

      expect(result, 'url.com');
      verify(() => mockRepository.creteExpense(expense: expenseSample))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
